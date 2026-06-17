<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\User;

class DashboardController extends Controller
{
    public function index()
    {
        $user = Auth::user();

        if (!$user) {
            return redirect()->route('login');
        }

        if ($user->role === 'admin') {
            return $this->adminDashboard();
        }

        return $this->userDashboard();
    }

    private function adminDashboard()
    {
        $categoryCounts = DB::table('components')
            ->join('component_types', 'components.type_id', '=', 'component_types.id')
            ->select('component_types.type_name', DB::raw('count(*) as count'))
            ->groupBy('component_types.type_name')
            ->pluck('count', 'type_name')
            ->toArray();

        $iconMap = [
            'CPU'                 => ['icon' => '', 'color' => 'blue'],
            'GPU'                 => ['icon' => '', 'color' => 'green'],
            'RAM'                 => ['icon' => '', 'color' => 'purple'],
            'CASE'                => ['icon' => '', 'color' => 'orange'],
            'MOTHERBOARD'         => ['icon' => '', 'color' => 'red'],
            'PSU'                 => ['icon' => '', 'color' => 'yellow'],
            'STORAGE'             => ['icon' => '', 'color' => 'pink'],
            'COOLER'              => ['icon' => '', 'color' => 'cyan'],
        ];

        $allTypes = DB::table('component_types')->pluck('type_name');
        $categories = $allTypes->map(function ($typeName) use ($categoryCounts, $iconMap) {
            return [
                'name'  => $typeName,
                'count' => $categoryCounts[$typeName] ?? 0,
                'icon'  => $iconMap[$typeName]['icon'] ?? '',
                'color' => $iconMap[$typeName]['color'] ?? 'gray',
            ];
        })->toArray();

        $stats = [
            'total_components' => DB::table('components')->count(),
            'total_users'      => User::where('role', '!=', 'admin')->count(),
            'total_builds'     => DB::table('pc_builds')->count(),
            'total_posts'      => DB::table('posts')->count(),
            'categories'       => $categories,
        ];

        $query = \App\Models\Component::with([
            'componentType',
            'cheapestPrice',
            'cpu', 'gpu', 'ram', 'storage', 'motherboard', 'psu', 'cooler', 'pcCase'
        ])
        ->join('component_types', 'components.type_id', '=', 'component_types.id')
        ->select('components.*');

        $selectedCategory = request()->query('category');
        if ($selectedCategory) {
            $query->where('component_types.type_name', '=', $selectedCategory);
        }

        $components = $query
            ->orderBy('component_types.type_name')
            ->orderBy('components.name')
            ->paginate(15)
            ->withQueryString()
            ->fragment('admin-components-table');

        return view('pages.admin.dashboard', compact('stats', 'components', 'selectedCategory'));
    }

    private function userDashboard()
    {
        $userId = Auth::id();

        $userStats = [
            'total_builds' => DB::table('pc_builds')->where('user_id', $userId)->count(),
            'total_posts'  => DB::table('posts')->where('user_id', $userId)->count(),
        ];

        $recentBuilds = DB::table('pc_builds')
            ->where('user_id', $userId)
            ->orderByDesc('created_at')
            ->limit(5)
            ->get();

        $recentPosts = DB::table('posts')
            ->where('user_id', $userId)
            ->orderByDesc('created_at')
            ->limit(5)
            ->get();

        return view('pages.user.dashboard', compact('userStats', 'recentBuilds', 'recentPosts'));
    }

    public function getComponentsTable()
    {
        $query = \App\Models\Component::with([
            'componentType',
            'cheapestPrice',
            'cpu', 'gpu', 'ram', 'storage', 'motherboard', 'psu', 'cooler', 'pcCase'
        ])
        ->join('component_types', 'components.type_id', '=', 'component_types.id')
        ->select('components.*');

        $selectedCategory = request()->query('category');
        if ($selectedCategory) {
            $query->where('component_types.type_name', '=', $selectedCategory);
        }

        $components = $query
            ->orderBy('component_types.type_name')
            ->orderBy('components.name')
            ->paginate(15)
            ->withQueryString();

        return view('pages.admin.components-table', compact('components', 'selectedCategory'));
    }
}
