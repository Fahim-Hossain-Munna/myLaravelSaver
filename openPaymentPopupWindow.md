```
const openPopupWindow = (url, debug = false) => {
            if (debug) console.log(`Opening payment window: ${url}`);

            const winWidth = 700;
            const winHeight = 700;
            const left = screen.width / 2 - winWidth / 2;
            const top = screen.height / 2 - winHeight / 2;

            const options = `resizable,height=${winHeight},width=${winWidth},top=${top},left=${left}`;
            const win = window.open(url, "_blank", options);

            if (!win) {
                if (debug) console.error("Failed to open payment window");
                alert("Popup blocked! Please allow popups.");
                return;
            }

            win.document.title = "Payment Window - Make Payment";

            let intervalID = null;

            const trackWindow = () => {
                try {
                    if (win.closed) {
                        if (debug) console.log("Window manually closed");
                        clearInterval(intervalID);
                        return;
                    }

                    const currentHost = location.host;

                    // Only check if same-origin
                    if (win.location.host === currentHost) {
                        const pathname = win.location.pathname;

                        if (pathname.includes("payment/success")) {
                            clearInterval(intervalID);

                            // Close payment plan modal
                            const modalEl = document.querySelector('.modal.show');
                            if (modalEl) {
                                const modalInstance = bootstrap.Modal.getInstance(modalEl);
                                modalInstance?.hide();
                            }

                            // Notify parent window
                            if (window) {
                                window.postMessage({
                                    status: 'success'
                                }, '*');
                            }
                            if (debug) console.log("Payment successful");

                            Swal.fire({
                                icon: "success",
                                title: "Payment Successful!",
                                text: "Your payment process was successful. Thank you for your payment.",
                            });

                            win.close();

                        } else {
                            clearInterval(intervalID);
                            if (debug) console.log("Payment failed");
                            win.close();
                            Swal.fire({
                                icon: "error",
                                title: "Payment Failed!",
                                text: "Your payment process was unsuccessful. Please try again.",
                            });
                        }
                    }

                } catch (e) {
                    if (debug) console.warn(
                        "Cross-origin access blocked; cannot track status until redirect returns to same-origin."
                    );
                }
            };

            intervalID = setInterval(trackWindow, 100); // check every 100ms
            win.focus();
        };

```
