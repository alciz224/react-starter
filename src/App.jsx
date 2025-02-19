// src/App.jsx
import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { Container } from 'react-bootstrap';
import { AuthProvider } from './contexts/AuthContext';

// Layout components
import Navbar from './components/layout/Navbar';
import Footer from './components/layout/Footer';

// Page components
import Home from './components/pages/Home';
import Login from './components/auth/Login';
import Register from './components/auth/Register';
import ProtectedPage from './components/pages/ProtectedPage';
import Profile from './components/pages/Profile';
import PrivateRoute from './components/auth/PrivateRoute';

// Styles
import 'bootstrap/dist/css/bootstrap.min.css';
import './App.css';

const App = () => {
  return (
    <BrowserRouter>
      <AuthProvider>
        <div className="d-flex flex-column min-vh-100">
          <Navbar />
          <Container className="flex-grow-1 py-3">
            <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/login" element={<Login />} />
              <Route path="/register" element={<Register />} />
              {/* Protected routes */}
              <Route element={<PrivateRoute />}>
                <Route path="/protected" element={<ProtectedPage />} />
                <Route path="/profile" element={<Profile />} />
              </Route>
            </Routes>
          </Container>
          <Footer />
        </div>
      </AuthProvider>
    </BrowserRouter>
  );
};

export default App;

