<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProfileUpdateRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Illuminate\View\View;

class ProfileController extends Controller
{
    /**
     * Display the user's profile form.
     */
    public function edit(Request $request): View
    {
        return view('pages.user.profile', [
            'user' => $request->user(),
            'avatarUrl' => $this->getUserAvatarUrl($request->user()),
        ]);
    }

    /**
     * Update the user's profile information.
     */
    public function update(ProfileUpdateRequest $request): RedirectResponse
    {
        $request->user()->fill($request->validated());

        if ($request->user()->isDirty('email')) {
            $request->user()->email_verified_at = null;
        }

        if ($request->hasFile('avatar')) {
            $this->saveUserAvatar($request->user()->id, $request->file('avatar'));
        }

        $request->user()->save();

        return Redirect::route('profile.edit')->with('status', 'profile-updated');
    }

    private function getUserAvatarUrl(\App\Models\User $user): ?string
    {
        $extensions = ['jpg', 'jpeg', 'png', 'webp'];
        foreach ($extensions as $ext) {
            $path = public_path("images/user/{$user->id}.{$ext}");
            if (file_exists($path)) {
                return asset("images/user/{$user->id}.{$ext}");
            }
        }

        return null;
    }

    private function saveUserAvatar(int $userId, \Illuminate\Http\UploadedFile $avatar)
    {
        $folder = public_path('images/user');
        if (!is_dir($folder)) {
            mkdir($folder, 0755, true);
        }

        $extension = strtolower($avatar->extension());
        $filename = "{$userId}.{$extension}";

        foreach (['jpg', 'jpeg', 'png', 'webp'] as $ext) {
            $oldPath = "{$folder}/{$userId}.{$ext}";
            if (file_exists($oldPath) && $ext !== $extension) {
                unlink($oldPath);
            }
        }

        $avatar->move($folder, $filename);
    }

    /**
     * Delete the user's account.
     */
    public function destroy(Request $request): RedirectResponse
    {
        $request->validateWithBag('userDeletion', [
            'password' => ['required', 'current_password'],
        ]);

        $user = $request->user();

        Auth::logout();

        $user->delete();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return Redirect::to('/');
    }
}
