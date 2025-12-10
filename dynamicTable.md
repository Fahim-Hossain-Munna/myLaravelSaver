### Reusable Blade table component 

#### This code is for component calling :

```bash
<form method="GET" class="mb-3">
    <input type="text" name="search" class="form-control" 
           placeholder="Search..." value="{{ $search }}">
</form>

<x-dynamic-table 
    :columns="[
        'id' => 'ID',
        'thumbnail => 'Thumbnail',0
        'name' => 'Name',
        'email' => 'Email',
        'phone' => 'Phone',
        'status' => 'Status',
    ]"

    :rows="$clients->map(fn($c) => [
        'id' => generateID($c->id),
        'thumbnail => $c->thumbnail,
        'name' => $c->name,
        'email' => $c->email,
        'phone' => $c->phone,
        'status' => $c->is_approved,
    ])"

    :pagination="$clients"
/>
```

#### This code is for table blade file :

```bash
@props([
    'columns' => [],
    'rows' => [],
    'pagination' => null,
])

<div class="table-responsive">
    <table class="table table-striped align-middle modern-table">
        <thead>
            <tr>
                @foreach ($columns as $key => $label)
                    <th>{{ $label }}</th>
                @endforeach
            </tr>
        </thead>

        <tbody>
            @forelse ($rows as $row)
                <tr>
                    @foreach ($columns as $key => $label)

                        {{-- Dynamic image --}}
                        @if (str_contains($key, 'thumbnail'))
                            <td><img src="{{ $row[$key] ?? '' }}" width="40"></td>

                        {{-- Dynamic boolean status --}}
                        @elseif ($key === 'status')
                            <td>
                                <span class="badge {{ ($row[$key] ?? false) ? 'bg-success' : 'bg-warning' }}">
                                    {{ ($row[$key] ?? false) ? 'Approved' : 'Pending' }}
                                </span>
                            </td>

                        {{-- Default --}}
                        @else
                            <td>{{ $row[$key] ?? '' }}</td>
                        @endif

                    @endforeach
                </tr>
            @empty
                <tr>
                    <td colspan="100%" class="text-center text-danger">No Data Found</td>
                </tr>
            @endforelse
        </tbody>
    </table>
</div>

{{-- PAGINATION --}}
@if ($pagination)
    <div class="mt-3">
        {{ $pagination->links() }}
    </div>
@endif
```

#### Remove/add columns based on role

```bash
:columns="auth()->user()->isAdmin() 
    ? ['id'=>'ID','name'=>'Name','email'=>'Email','status'=>'Status']
    : ['name'=>'Name','email'=>'Email']"
```

