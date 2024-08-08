<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bank Application</title>
   <style>
   /* Global Styles */

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background-color: #f9f9f9;
    background-image: linear-gradient(to right, #333 0%, #2575fc 100%);
}

h1, h2, h3, h4, h5, h6 {
    font-weight: bold;
    color: #212121;
}

p {
    margin-bottom: 20px;
}

button {
    background-color: #4CAF50;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #3e8e41;
}

a {
    color: #4CAF50;
    text-decoration: none;
    transition: color 0.3s ease;
}

a:hover {
    color: #3e8e41;
}

/* Header Section */

header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

nav {
    display: flex;
    align-items: center;
}

nav ul {
    display: flex;
    list-style: none;
}

nav li {
    margin-right: 20px;
}

.nav-toggle {
    display: none;
}

.logo {
    img {
        height: 50px;
    }
}

/* Hero Section */

.hero {
    position: relative;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    color: #fff;
    overflow: hidden;
}

.hero .background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
    overflow: hidden;
}

.hero .background img {
    width: 100%;
    height: auto;
    object-fit: cover;
    transform: translateX(-50%) translateY(-50%);
    filter: brightness(50%);
}

.hero .content {
    max-width: 800px;
    text-align: center;
}

.hero .content h1 {
    font-size: 48px;
    margin-bottom: 20px;
}

.hero .content p {
    font-size: 24px;
    margin-bottom: 40px;
}

.hero .content .buttons {
    display: flex;
    justify-content: center;
    align-items: center;
}

.hero .content .buttons button {
    margin: 0 10px;
}

/* Features Section */

.features {
    padding: 80px 0;
    background-color: #fff;
    text-align: center;
}

.features h2 {
    font-size: 36px;
    margin-bottom: 60px;
}

.features .feature-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-gap: 30px;
}

.features .feature {
    text-align: left;
    padding: 30px;
    border: 1px solid #ddd;
    border-radius: 5px;
    transition: transform 0.3s ease;
}

.features .feature:hover {
    transform: translateY(-5px);
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.features .feature i {
    font-size: 48px;
    color: #4CAF50;
    margin-bottom: 20px;
}

.features .feature h3 {
    font-size: 24px;
    margin-bottom: 20px;
}

.features .feature p {
    font-size: 18px;
    margin-bottom: 30px;
}

.features .feature button {
    margin-bottom: 0;
}

/* Testimonials Section */

.testimonials{
    padding: 80px 0;
    background-color: #f9f9f9;
    text-align: center;
}

.testimonials h2 {
    font-size: 36px;
    margin-bottom: 60px;
}

.testimonials.testimonial-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-gap: 30px;
}

.testimonials.testimonial {
    text-align: left;
    padding: 30px;
    border: 1px solid #ddd;
    border-radius: 5px;
    transition: transform 0.3s ease;
}

.testimonials.testimonial:hover {
    transform: translateY(-5px);
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.testimonials.testimonial img {
    width: 50px;
    max-width: 50px;
    height: 50px;
    border-radius: 50%;
    margin-bottom: 20px;
}

.testimonials.testimonial p {
    font-size: 18px;
    margin-bottom: 30px;
}

.testimonials.testimonial span {
    font-size: 16px;
    color: #666;
}


/* Call-to-Action Section */

.cta {
    padding: 80px 0;
    background-color: #4CAF50;
    color: #fff;
    text-align: center;
}

.cta h2 {
    font-size: 36px;
    margin-bottom: 60px;
}

.cta p {
    font-size: 24px;
    margin-bottom: 40px;
}

.cta button {
    margin: 0 10px;
    background-color: #fff;
    color: #4CAF50;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.cta button:hover {
    background-color: #3e8e41;
}

/* Footer Section */

footer {
    padding: 20px 0;
    background-color: #333;
    color: #fff;
    text-align: center;
}

footer p {
    margin-bottom: 20px;
}
.img1{
max-width:200px;
}

footer ul {
    list-style: none;
    display: flex;
    justify-content: center;
    align-items: center;
}

footer li {
    margin: 0 10px;
}

footer a {
    color: #fff;
    text-decoration: none;
    transition: color 0.3s ease;
}

footer a:hover {
    color: #3e8e41;
}
   </style>
</head>
<body>
    <!-- Header Section -->
    <header>
        <nav>
            <ul>
                <li><a href="#">About Us</a></li>
                <li><a href="#">Contact Us</a></li>
            </ul>
            <div class="nav-toggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </nav>
        <div class="logo">
            <img src="images/home1.gif" alt="Bank Logo">
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
      
        <div class="content">
            <h1>Welcome to Our Bank</h1>
            <p>Experience the future of banking with our innovative services</p>
            <div class="buttons">
            <button class="admin-login" onclick="location.href='login.jsp'">Admin Login</button>
            <button class="customer-login" onclick="location.href='Customerlogin.jsp'">Customer Login</button>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <h2>Our Key Features</h2>
        <div class="feature-grid">
            <div class="feature">
                <i class="fas fa-mobile-alt"></i>
                <h3>Mobile Banking</h3>
                <p>Bank on-the-go with our mobile app</p>
                <button>Learn More</button>
            </div>
            <div class="feature">
                <i class="fas fa-lock"></i>
                <h3>Secure Online Banking</h3>
                <p>Protect your accounts with our advanced security features</p>
                <button>Learn More</button>
            </div>
            <div class="feature">
                <i class="fas fa-chart-line"></i>
                <h3>Investment Options</h3>
                <p>Grow your wealth with our investment services</p>
                <button>Learn More</button>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials">
        <h2>What Our Customers Say</h2>
        <div class="testimonial-grid">
            <div class="testimonial">
                <img src="images/globe_10.gif" alt="Customer 1">
                <p>"I'm impressed with the bank's customer service. They're always helpful and responsive."</p>
                <span>- John Doe</span>
            </div>
            <div class="testimonial">
                <img src="images/2.jpg" class=img1 alt="Customer 2">
                <p>"The mobile app is so convenient. I can bank anywhere, anytime."</p>
                <span>- Jane Smith</span>
            </div>
        </div>
    </section>

    <!-- Call-to-Action Section -->
    <section class="cta">
        <h2>Get Started Today</h2>
        <p>Open an account or learn more about our services</p>
        <button>Open an Account</button>
        <button>Learn More</button>
    </section>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2024 Mastan Bank Application. All rights reserved.</p>
        <ul>
            <li><a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
            <li><a href="#" target="_blank"><i class="fab fa-twitter"></i></a></li>
            <li><a href="#" target="_blank"><i class="fab fa-instagram"></i></a></li>
        </ul>
    </footer>

    <script >
 // Navigation Menu Toggle
    const navToggle = document.querySelector('.nav-toggle');
    const navMenu = document.querySelector('nav ul');

    navToggle.addEventListener('click', () => {
        navMenu.classList.toggle('active');
    });
    </script>
</body>
</html>