document.addEventListener('DOMContentLoaded', () => {
    // Add event listener for the "Pay Now" button
    const payButton = document.getElementById('pay-button');
    if (payButton) {
        payButton.addEventListener('click', handlePayment);
    }
});

/**
 * Function to handle Razorpay payment integration.
 */
function handlePayment() {
    // Get the total price from the cart (convert it to paise)
    const totalPriceElement = document.getElementById('total-price');
    if (!totalPriceElement) {
        alert("Total price not found!");
        return;
    }

    const totalPrice = parseFloat(totalPriceElement.textContent.replace('$', '')) * 100; // Convert to paise
    if (isNaN(totalPrice) || totalPrice <= 0) {
        alert("Invalid total price!");
        return;
    }

    // Razorpay payment options
    const options = {
        key: "LIVE_KEY_ID", // Replace this with your actual Live Razorpay Key ID
        amount: totalPrice,
        currency: "INR",
        name: "Handloom Fashion",
        description: "Purchase Handloom Items",
        image: "/logo.png", // Optional logo URL
        callback_url: "https://yourdomain.com/payment/confirm", // Replace with your live backend callback URL
        prefill: {
            name: "Customer Name", // Replace with actual customer data if available
            email: "customer@example.com" // Replace with actual customer email
        },
        theme: {
            color: "#6a1b9a"
        },
        handler: function (response) {
            // Payment success handler
            alert(`Payment Successful!\nPayment ID: ${response.razorpay_payment_id}`);
            // Optionally, redirect to a confirmation page or update your UI
            window.location.href = '/confirmation.html';
        },
        modal: {
            ondismiss: function () {
                // Handle if user closes the payment modal
                alert("Payment process was cancelled.");
            }
        }
    };

    // Initialize and open Razorpay payment gateway
    const rzp = new Razorpay(options);
    rzp.on('payment.failed', function (response) {
        // Payment failure handler
        alert(`Payment Failed!\nReason: ${response.error.description}`);
    });
    rzp.open();
}
