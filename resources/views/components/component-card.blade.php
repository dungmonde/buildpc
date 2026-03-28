<div class="bg-gray-800 rounded-lg p-4 hover:bg-gray-700">
    <img src="{{ $imageUrl ?? 'placeholder.jpg' }}" class="w-full h-40 object-contain">
    <h3 class="font-semibold mt-2">{{ $name }}</h3>
    <p class="text-gray-400 text-sm">{{ $type }}</p>
    <p class="text-green-400 font-bold mt-1">${{ $price }}</p>
    <button class="mt-2 w-full bg-blue-600 rounded py-1 text-sm">
        + Thêm vào Build
    </button>
</div>