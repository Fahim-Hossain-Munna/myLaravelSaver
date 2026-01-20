####  This is HTML Stucture for OTP,
```bash
  <div class="flex justify-center gap-4 sm:gap-3">
      @for ($i = 1; $i <= 4; $i++)
          <input type="text" name="otp[]" maxlength="1" inputmode="text"
              class="w-12 h-12 sm:w-14 sm:h-14 text-center text-lg sm:text-xl rounded-lg border-[1.5px] border-gray-100 focus:border-reefBlue-900 focus:outline-none"
              required>
      @endfor
  </div>
```

####  This is Script for OTP,
```bash
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input[name="otp[]"]');

            inputs.forEach((input, index) => {

                // Allow only alphanumeric characters
                input.addEventListener('input', (e) => {
                    input.value = input.value.replace(/[^a-zA-Z0-9]/g, '');

                    if (input.value && index < inputs.length - 1) {
                        inputs[index + 1].focus();
                    }
                });

                // Backspace handling
                input.addEventListener('keydown', (e) => {
                    if (e.key === 'Backspace' && !input.value && index > 0) {
                        inputs[index - 1].focus();
                    }
                });

                // Paste full OTP
                input.addEventListener('paste', (e) => {
                    e.preventDefault();
                    const pasteData = e.clipboardData.getData('text').replace(/[^a-zA-Z0-9]/g, '');
                    if (!pasteData) return;

                    let currentIndex = index;
                    pasteData.split('').forEach((char) => {
                        if (currentIndex < inputs.length) {
                            inputs[currentIndex].value = char;
                            currentIndex++;
                        }
                    });

                    const lastIndex = Math.min(index + pasteData.length, inputs.length) - 1;
                    inputs[lastIndex]?.focus();
                });
            });
        });
    </script>
```

#### OTP Mail Template HTML Design

```
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>{{ $subject ?? 'Your Password Reset Code' }}</title>

    <style>
        body,
        table,
        td {
            font-family: "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        }

        img {
            border: 0;
            outline: none;
        }

        a {
            text-decoration: none;
        }

        .wrapper {
            width: 100%;
            background: #f3f4f6;
            padding: 30px 15px;
        }

        .email-container {
            max-width: 650px;
            background: #ffffff;
            margin: auto;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #e5e7eb;
        }

        .email-header {
            background: linear-gradient(90deg, #0a7f8c, #1a1a1a);
            padding: 25px 30px;
            color: #ffffff;
            font-size: 20px;
            font-weight: bold;
        }

        .email-body {
            padding: 28px 30px;
            font-size: 15px;
            color: #111827;
            line-height: 1.6;
        }

        .email-footer {
            padding: 14px 25px;
            text-align: center;
            font-size: 12px;
            color: #6b7280;
            background: #f9fafb;
        }

        @media (max-width: 480px) {
            .email-body {
                padding: 20px;
                font-size: 14px;
            }

            .email-header {
                padding: 18px 20px;
                font-size: 18px;
            }
        }
    </style>
</head>

<body>

    <table class="wrapper" role="presentation" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center">

                <table class="email-container" role="presentation" cellspacing="0" cellpadding="0" width="100%">

                    <!-- HEADER -->
                    <tr>
                        <td class="email-header">
                            {{ config('app.site_title', config('app.name')) }}
                        </td>
                    </tr>

                    <!-- BODY -->
                    <tr>
                        <td class="email-body">
                            <p style="margin:0 0 18px;">
                                You requested to reset your password.
                                Use the One-Time Password (OTP) below to continue.
                            </p>

                            <!-- OTP BOX DESIGN -->
                            <table role="presentation" cellspacing="0" cellpadding="0" align="center"
                                style="margin:22px auto;">
                                <tr>
                                    @foreach (str_split($otp) as $digit)
                                        <td
                                            style="
                                        width: 50px;
                                        height: 50px;
                                        border: 2px solid #0a7f8c;
                                        border-radius: 8px;
                                        text-align: center;
                                        vertical-align: middle;
                                        font-size: 22px;
                                        font-weight: 700;
                                        color: #0a7f8c;
                                        ">
                                            {{ $digit }}
                                        </td>
                                        <td width="8"></td>
                                    @endforeach
                                </tr>
                            </table>

                            <!-- Fallback -->
                            <p style="text-align:center;font-size:13px;color:#6b7280;">
                                OTP Code: <strong>{{ $otp }}</strong>
                            </p>

                            <p style="margin:18px 0 0;">
                                If you did not request this code, please ignore this email or contact our support team.
                            </p>

                            <p style="margin:20px 0 0;">
                                Thanks,<br>
                                <strong>{{ config('app.site_title', config('app.name')) }} Team</strong>
                            </p>

                        </td>
                    </tr>

                    <!-- FOOTER -->
                    <tr>
                        <td class="email-footer">
                            © {{ date('Y') }} {{ config('app.site_title', config('app.name')) }}. All Rights
                            Reserved.
                        </td>
                    </tr>

                </table>

            </td>
        </tr>
    </table>

</body>

</html>
```






    
