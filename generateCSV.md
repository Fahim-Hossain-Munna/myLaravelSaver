### Here the example how to generate CSV file from table
```
        // Generate CSV content
        $csvContent = "SL,Date,Course,Category,Price,Total Enroll,Total Transactions,Grand Total\n";
        foreach ($reportsQuery as $index => $report) {
            $csvContent .= implode(',', [
                $index + 1,
                $report->created_at,
                $report->title,
                $report->category->title ?? 'N/A',
                $report->price,
                $report->enrollments->count(),
                $report->transactions->count(),
                $report->transactions->sum('payment_amount') ?? 'N/A',
            ]) . "\n";
        }

        // Send response as a CSV file
        return response($csvContent)
            ->header('Content-Type', 'text/csv')
            ->header('Content-Disposition', 'attachment; filename="report.csv"');
    }
```

### Another Export CSV Option Bellow,

```
    public function exportCsv()
    {
        $search = request()->search;
        $city = request()->city;
        $branches = $this->headBranchRepo->query()
            ->when($search, function ($query) use ($search) {
                $query->where(function ($q) use ($search) {
                    $q->where('company_name', 'like', "%{$search}%")
                    ->orWhere('company_type', 'like', "%{$search}%")
                    ->orWhere('csn_id', 'like', "%{$search}%")
                    ->orWhere('vat_id', 'like', "%{$search}%")
                    ->orWhere('phone', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%");
                });
            })
            ->when($city, function ($query) use ($city) {
                $query->where('city_id', $city);
            })
            ->get();

        $headers = [
            'Content-Type'        => 'text/csv',
            'Content-Disposition' => 'attachment; filename="leads_' . now()->format('Ymd_His') . '.csv"',
        ];

        $columns = ['ID','Branch Name','CSN ID','VAT ID','Branch Type','Province','City','Phone','Email',
                    'Opening Date','Address'];


        return response()->stream(function () use ($branches, $columns) {
            $file = fopen('php://output', 'w');
            fputcsv($file, $columns);
            foreach ($branches as $b) {
                fputcsv($file, [
                    $b->id,
                    $b->csn_id,
                    $b->vat_id,
                    $b->province->name,
                    $b->city->name,
                    $b->phone,
                    $b->email,
                    $b->created_at->format('M d, Y'),
                    $b->address,
                ]);
            }
            fclose($file);
        }, 200, $headers);
    }
```
    
