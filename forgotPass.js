const express = require('express');
const nodemailer = require('nodemailer');
const crypto = require('crypto');

const app = express();
app.set('view engine', 'ejs');
app.use(express.urlencoded({ extended: true }));


const EMAIL_USERNAME = 'your_email_username';
const EMAIL_PASSWORD = 'your_email_password';
const EMAIL_HOST = 'your_email_host';
const EMAIL_PORT = 587;

// In-memory storage for tokens and associated email addresses
const tokenStore = {};

// Generate a random token using crypto library
function generateToken() {
  return crypto.randomBytes(32).toString('hex');
}

// Configure nodemailer to send emails
const transporter = nodemailer.createTransport({
  host: EMAIL_HOST,
  port: EMAIL_PORT,
  secure: false,
  auth: {
    user: EMAIL_USERNAME,
    pass: EMAIL_PASSWORD,
  },
});

// Render the forgot password form
app.get('/forgot-password', (req, res) => {
  res.render('forgot-password');
});

// Handle the forgot password form submission
app.post('/forgot-password', (req, res) => {
  const email = req.body.email;

  // Generate a token and store it in tokenStore with the associated email
  const token = generateToken();
  tokenStore[email] = token;

  // Create the email message
  const mailOptions = {
    from: EMAIL_USERNAME,
    to: email,
    subject: 'Password Reset',
    text: `To reset your password, click the following link: http://yourwebsite.com/reset-password/${token}`,
  };

  // Send the email
  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.log(error);
      res.send('An error occurred while sending the email.');
    } else {
      console.log('Email sent: ' + info.response);
      res.send('An email with password reset instructions has been sent.');
    }
  });
});

// Render the password reset form
app.get('/reset-password/:token', (req, res) => {
  const token = req.params.token;

  // Check if the token exists in tokenStore
  if (tokenStore[token]) {
    res.render('reset-password', { token });
  } else {
    res.send('Invalid or expired token.');
  }
});

// Handle the password reset form submission
app.post('/reset-password/:token', (req, res) => {
  const token = req.params.token;
  const newPassword = req.body.password;

  // Check if the token exists in tokenStore
  if (tokenStore[token]) {
    // Update the password for the associated email address
    // Replace this with your own password update logic
    console.log(`Updating password for ${tokenStore[token]} to ${newPassword}`);

    // Delete the token from tokenStore
    delete tokenStore[token];

    res.send('Your password has been successfully reset.');
  } else {
    res.send('Invalid or expired token.');
  }
});
