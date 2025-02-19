// src/components/layout/Footer.jsx
import React from 'react';

const Footer = () => (
  <footer className="bg-dark text-white py-4 mt-auto">
    <div className="container text-center">
      <p className="mb-0">© {new Date().getFullYear()} - JWT Auth Starter Template</p>
      <small>Made with React & Bootstrap</small>
    </div>
  </footer>
);

export default Footer;
