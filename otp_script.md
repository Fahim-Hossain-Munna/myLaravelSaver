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






    
