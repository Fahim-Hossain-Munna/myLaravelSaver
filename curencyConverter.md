```
if ($request->payment_gateway == 'aamarpay') {
            $currency = config('app.currency');
            if ($currency != 'BDT') {

                $currencyConversionApi = "https://v6.exchangerate-api.com/v6/efe128e2762a67a6b7dabb59/latest/$currency";

                $jsonResponse = file_get_contents($currencyConversionApi);

                // Continuing if we got a result
                if (false !== $jsonResponse) {

                    // Try/catch for json_decode operation
                    try {

                        // Decoding
                        $response = json_decode($jsonResponse);

                        // Check for success
                        if ('success' === $response->result) {
                            // YOUR APPLICATION CODE HERE, e.g.
                            $currentPrice = $amount; // Your price in USD
                            $amount = round(($currentPrice * $response->conversion_rates->BDT), 2);
                        }
                    } catch (Exception $e) {
                        $amount  = $amount * 100;
                    }
                }
            }
        }
```
