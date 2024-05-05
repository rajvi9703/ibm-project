<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 500px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        .status-message {
            padding: 15px;
            background-color: #e2f3e9;
            border: 1px solid #bee5d3;
            color: #155724;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        @media (max-width: 600px) {
            .container {
                padding: 10px;
            }

            .status-message {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Order Status</h1>
        <div class="status-message">
            <p>Your order cancelation status is initiated. Check your email for more information.</p>
        </div>
        <a href="chatbotmain.html" class="btn">Back to Home</a>
    </div>
</body>
</html>
