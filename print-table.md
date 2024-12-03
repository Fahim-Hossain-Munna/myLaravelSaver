> Print Table using Raw JS
```
    <script>
        function printTable() {
            // Get the table element
            const table = document.querySelector('#deleteTableItem .table-responsive');

            // Create a new window for printing
            const printWindow = window.open('', '', 'width=800,height=600');

            // Write the table HTML to the new window
            printWindow.document.write(`
            <html>
                <head>
                    <title>Print Table</title>
                    <style>
                        /* Custom styles for the printed table */
                        body {
                            font-family: Arial, sans-serif;
                            margin: 20px;
                        }
                        table {
                            width: 100%;
                            border-collapse: collapse;
                        }
                        table, th, td {
                            border: 1px solid black;
                        }
                        th, td {
                            padding: 10px;
                            text-align: left;
                        }
                        th {
                            background-color: #f4f4f4;
                        }
                    </style>
                </head>
                <body>
                    ${table.outerHTML}
                </body>
            </html>
        `);

            // Close the document to signal readiness for printing
            printWindow.document.close();

            // Trigger the print dialog
            printWindow.print();

            // Optionally close the print window after printing
            printWindow.onafterprint = function() {
                printWindow.close();
            };
        }
    </script>
  ``` 
