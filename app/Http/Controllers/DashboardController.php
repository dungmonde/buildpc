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
        // Đếm component theo type_name (join với component_types)
        $categoryCounts = DB::table('components')
            ->join('component_types', 'components.type_id', '=', 'component_types.id')
            ->select('component_types.type_name', DB::raw('count(*) as count'))
            ->groupBy('component_types.type_name')
            ->pluck('count', 'type_name')
            ->toArray();

        $iconMap = [
            'CPU'              => ['icon' => '', 'color' => 'blue'],
            'Video Card'       => ['icon' => '', 'color' => 'green'],
            'Memory'           => ['icon' => '', 'color' => 'purple'],
            'Case'             => ['icon' => '', 'color' => 'orange'],
            'Motherboard'      => ['icon' => '', 'color' => 'red'],
            'Power Supply'     => ['icon' => '', 'color' => 'yellow'],
            'Internal Hard Drive' => ['icon' => '', 'color' => 'pink'],
            'CPU Cooler'       => ['icon' => '', 'color' => 'cyan'],
        ];

        // Lấy tất cả type_name thật từ DB, map icon nếu có
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

        // Danh sách linh kiện kèm type_name, giá thấp nhất từ component_prices
        $query = DB::table('components')
            ->join('component_types', 'components.type_id', '=', 'component_types.id')
            ->leftJoin(DB::raw('(SELECT component_id, MIN(price) as min_price FROM component_prices GROUP BY component_id) cp'), 'components.id', '=', 'cp.component_id')
            ->select(
                'components.id',
                'components.name',
                'component_types.type_name as category',
                DB::raw('COALESCE(components.base_price, cp.min_price) as price')
            );

        // Filter by category if provided
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
        // Danh sách linh kiện kèm type_name, giá thấp nhất từ component_prices
        $query = DB::table('components')
            ->join('component_types', 'components.type_id', '=', 'component_types.id')
            ->leftJoin(DB::raw('(SELECT component_id, MIN(price) as min_price FROM component_prices GROUP BY component_id) cp'), 'components.id', '=', 'cp.component_id')
            ->select(
                'components.id',
                'components.name',
                'component_types.type_name as category',
                DB::raw('COALESCE(components.base_price, cp.min_price) as price')
            );

        // Filter by category if provided
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
