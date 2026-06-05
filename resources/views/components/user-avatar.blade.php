@props([
    'user',
    'size' => 10,
    'class' => '',
    'background' => 'bg-slate-100',
    'textClass' => 'text-slate-600',
])

@php
    $avatarUrl = null;
    if ($user?->id) {
        foreach (['jpg', 'jpeg', 'png', 'webp'] as $ext) {
            $path = public_path("images/user/{$user->id}.{$ext}");
            if (file_exists($path)) {
                $avatarUrl = asset("images/user/{$user->id}.{$ext}");
                break;
            }
        }
    }

    $initial = strtoupper(substr($user?->name ?? 'U', 0, 1));
    $sizeClass = "h-{$size} w-{$size}";
    $shapeClass = str_contains($class, 'rounded-') ? '' : 'rounded-full';
@endphp

@if($avatarUrl)
    <img src="{{ $avatarUrl }}" alt="{{ $user?->name ?? 'Avatar' }}" class="{{ $sizeClass }} {{ $shapeClass }} {{ $class }} object-cover" />
@else
    <div class="{{ $sizeClass }} {{ $shapeClass }} {{ $class }} {{ $background }} inline-flex items-center justify-center font-bold {{ $textClass }}">
        {{ $initial }}
    </div>
@endif
