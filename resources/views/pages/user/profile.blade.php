@extends('layouts.app')

@section('content')
<div class="max-w-6xl mx-auto px-6 py-10">
    <div class="mb-8">
        <h1 class="text-3xl font-semibold text-slate-900">Hồ sơ cá nhân</h1>
        <p class="mt-2 text-slate-600">Cập nhật ảnh đại diện, tên và email của bạn.</p>
    </div>

    @if (session('status') === 'profile-updated')
        <div class="mb-6 rounded-3xl border border-emerald-200 bg-emerald-50 p-4 text-emerald-800">
            Hồ sơ đã được cập nhật thành công.
        </div>
    @endif

    <form method="POST" action="{{ route('profile.update') }}" enctype="multipart/form-data" class="grid gap-6 lg:grid-cols-[320px_1fr]">
        @csrf
        @method('patch')

        <section class="rounded-3xl bg-white p-6 shadow-sm ring-1 ring-slate-200">
            <div class="flex flex-col items-center gap-5 text-center">
                @if ($avatarUrl)
                    <img src="{{ $avatarUrl }}" alt="Avatar" class="h-28 w-28 rounded-full object-cover ring-2 ring-slate-200" />
                @else
                    <div class="flex h-28 w-28 items-center justify-center rounded-full bg-slate-100 text-4xl font-semibold text-slate-700 ring-2 ring-slate-200">
                        {{ strtoupper(substr($user->name, 0, 1)) }}
                    </div>
                @endif

                <div>
                    <p class="text-lg font-semibold text-slate-900">{{ $user->name }}</p>
                    <p class="text-sm text-slate-500">{{ $user->email }}</p>
                </div>
            </div>

            <div class="mt-8 space-y-4">
                <div>
                    <label for="avatar" class="block text-sm font-medium text-slate-700">Ảnh đại diện</label>
                    <input id="avatar" name="avatar" type="file" accept="image/*" class="mt-2 block w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-sm text-slate-700 focus:border-slate-400 focus:outline-none focus:ring-2 focus:ring-slate-300" />
                    @error('avatar')
                        <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <p class="text-sm text-slate-500">Chọn tệp ảnh JPG, JPEG, PNG hoặc WEBP với dung lượng tối đa 5MB.</p>
            </div>
        </section>

        <section class="rounded-3xl bg-white p-6 shadow-sm ring-1 ring-slate-200">
            <div class="space-y-6">
                <div>
                    <label for="name" class="block text-sm font-medium text-slate-700">Tên</label>
                    <input id="name" name="name" type="text" value="{{ old('name', $user->name) }}" required class="mt-2 block w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-sm text-slate-800 focus:border-slate-400 focus:outline-none focus:ring-2 focus:ring-slate-300" />
                    @error('name')
                        <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <div>
                    <label for="email" class="block text-sm font-medium text-slate-700">Email</label>
                    <input id="email" name="email" type="email" value="{{ old('email', $user->email) }}" required class="mt-2 block w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-sm text-slate-800 focus:border-slate-400 focus:outline-none focus:ring-2 focus:ring-slate-300" />
                    @error('email')
                        <p class="mt-2 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                    <button type="submit" class="inline-flex items-center justify-center rounded-full bg-slate-900 px-7 py-3 text-sm font-semibold text-white transition hover:bg-slate-700">
                        Lưu thay đổi
                    </button>
                </div>
            </div>
        </section>
    </form>
</div>
@endsection
