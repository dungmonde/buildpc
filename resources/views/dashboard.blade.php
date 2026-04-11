@extends('layouts.app')

@section('content')
    @if(auth()->user()->role === 'admin')
        @include('pages.admin.dashboard')
    @else
        @include('pages.user.dashboard')
    @endif
@endsection