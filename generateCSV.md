>> Here the example how to generate CSV file from table
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
