#!/bin/bash
# Script to create the folder tree and content files

# Create directories
mkdir -p src/components/auth
mkdir -p src/components/layout
mkdir -p src/components/pages
mkdir -p src/contexts
mkdir -p src/services
mkdir -p src/utils

##############################################
# Create src/components/auth/Login.jsx
##############################################
cat << 'EOF' > src/components/auth/Login.jsx
// src/components/auth/Login.jsx
import React, { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { Form, Button, Card, Alert, Container } from 'react-bootstrap';

const Login = () => {
  const [username, setUsername]   = useState('');
  const [password, setPassword]   = useState('');
  const [loading, setLoading]     = useState(false);
  const [error, setError]         = useState('');
  
  const { logIn } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const from = location.state?.from?.pathname || '/';

  const handleLogin = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      await logIn(username, password);
      navigate(from, { replace: true });
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Container className="d-flex align-items-center justify-content-center" style={{ minHeight: "70vh" }}>
      <div className="w-100" style={{ maxWidth: "400px" }}>
        <Card>
          <Card.Body>
            <h2 className="text-center mb-4">Log In</h2>
            {error && <Alert variant="danger">{error}</Alert>}
            <Form onSubmit={handleLogin}>
              <Form.Group className="mb-3" controlId="username">
                <Form.Label>Username</Form.Label>
                <Form.Control
                  type="text"
                  required
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                />
              </Form.Group>
              <Form.Group className="mb-3" controlId="password">
                <Form.Label>Password</Form.Label>
                <Form.Control
                  type="password"
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                />
              </Form.Group>
              <Button disabled={loading} className="w-100 mt-4" type="submit">
                {loading ? (
                  <>
                    <span className="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
                    Loading...
                  </>
                ) : "Log In"}
              </Button>
            </Form>
          </Card.Body>
        </Card>
        <div className="w-100 text-center mt-2">
          Need an account? <Link to="/register">Register</Link>
        </div>
      </div>
    </Container>
  );
};

export default Login;
EOF

##############################################
# Create src/components/auth/Register.jsx
##############################################
cat << 'EOF' > src/components/auth/Register.jsx
// src/components/auth/Register.jsx
import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { Form, Button, Card, Alert, Container } from 'react-bootstrap';

const Register = () => {
  const [username, setUsername]         = useState('');
  const [email, setEmail]               = useState('');
  const [password, setPassword]         = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading]           = useState(false);
  const [error, setError]               = useState('');
  const [success, setSuccess]           = useState('');
  
  const { register } = useAuth();
  const navigate = useNavigate();

  const handleRegister = async (e) => {
    e.preventDefault();
    if (password !== confirmPassword) {
      return setError("Passwords don't match");
    }
    setError('');
    setLoading(true);
    try {
      await register(username, email, password);
      setSuccess('Registration successful! Redirecting to login...');
      setTimeout(() => navigate('/login'), 3000);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Container className="d-flex align-items-center justify-content-center" style={{ minHeight: "70vh" }}>
      <div className="w-100" style={{ maxWidth: "400px" }}>
        <Card>
          <Card.Body>
            <h2 className="text-center mb-4">Sign Up</h2>
            {error && <Alert variant="danger">{error}</Alert>}
            {success && <Alert variant="success">{success}</Alert>}
            <Form onSubmit={handleRegister}>
              <Form.Group className="mb-3" controlId="username">
                <Form.Label>Username</Form.Label>
                <Form.Control
                  type="text"
                  required
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                />
              </Form.Group>
              <Form.Group className="mb-3" controlId="email">
                <Form.Label>Email</Form.Label>
                <Form.Control
                  type="email"
                  required
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                />
              </Form.Group>
              <Form.Group className="mb-3" controlId="password">
                <Form.Label>Password</Form.Label>
                <Form.Control
                  type="password"
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  minLength="6"
                />
              </Form.Group>
              <Form.Group className="mb-3" controlId="confirm-password">
                <Form.Label>Confirm Password</Form.Label>
                <Form.Control
                  type="password"
                  required
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  minLength="6"
                />
              </Form.Group>
              <Button disabled={loading} className="w-100 mt-4" type="submit">
                {loading ? (
                  <>
                    <span className="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
                    Loading...
                  </>
                ) : "Register"}
              </Button>
            </Form>
          </Card.Body>
        </Card>
        <div className="w-100 text-center mt-2">
          Already have an account? <Link to="/login">Log In</Link>
        </div>
      </div>
    </Container>
  );
};

export default Register;
EOF

##############################################
# Create src/components/auth/PrivateRoute.jsx
##############################################
cat << 'EOF' > src/components/auth/PrivateRoute.jsx
// src/components/auth/PrivateRoute.jsx
import React from 'react';
import { Navigate, Outlet, useLocation } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';

const PrivateRoute = () => {
  const { isLoggedIn, loading } = useAuth();
  const location = useLocation();

  if (loading) {
    return (
      <div className="d-flex justify-content-center align-items-center vh-100">
        <div className="spinner-border" role="status">
          <span className="visually-hidden">Loading...</span>
        </div>
      </div>
    );
  }

  return isLoggedIn ? <Outlet /> : <Navigate to="/login" state={{ from: location }} replace />;
};

export default PrivateRoute;
EOF

##############################################
# Create src/components/layout/Navbar.jsx
##############################################
cat << 'EOF' > src/components/layout/Navbar.jsx
// src/components/layout/Navbar.jsx
import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { Navbar as BootstrapNavbar, Nav, Container, Button } from 'react-bootstrap';

const Navbar = () => {
  const { currentUser, logOut, isLoggedIn } = useAuth();
  const navigate = useNavigate();

  const handleLogout = async () => {
    try {
      await logOut();
      navigate('/');
    } catch (error) {
      console.error("Logout error", error);
    }
  };

  return (
    <BootstrapNavbar bg="dark" variant="dark" expand="lg">
      <Container>
        <BootstrapNavbar.Brand as={Link} to="/">JWT Auth Starter</BootstrapNavbar.Brand>
        <BootstrapNavbar.Toggle aria-controls="basic-navbar-nav" />
        <BootstrapNavbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link as={Link} to="/">Home</Nav.Link>
            {isLoggedIn && (
              <>
                <Nav.Link as={Link} to="/protected">Protected</Nav.Link>
                <Nav.Link as={Link} to="/profile">Profile</Nav.Link>
              </>
            )}
          </Nav>
          <Nav>
            {isLoggedIn ? (
              <>
                <Nav.Item className="d-flex align-items-center me-3">
                  <span className="text-light">Hello, {currentUser.username}!</span>
                </Nav.Item>
                <Button variant="outline-light" onClick={handleLogout}>Logout</Button>
              </>
            ) : (
              <>
                <Nav.Link as={Link} to="/login">Login</Nav.Link>
                <Nav.Link as={Link} to="/register">Register</Nav.Link>
              </>
            )}
          </Nav>
        </BootstrapNavbar.Collapse>
      </Container>
    </BootstrapNavbar>
  );
};

export default Navbar;
EOF

##############################################
# Create src/components/layout/Footer.jsx
##############################################
cat << 'EOF' > src/components/layout/Footer.jsx
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
EOF

##############################################
# Create src/components/pages/Home.jsx
##############################################
cat << 'EOF' > src/components/pages/Home.jsx
// src/components/pages/Home.jsx
import React from 'react';
import { Container, Row, Col, Card, Button } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';

const Home = () => {
  const { isLoggedIn } = useAuth();

  return (
    <Container>
      <Row className="my-5">
        <Col lg={8} className="mx-auto text-center">
          <h1>Welcome to JWT Auth Starter</h1>
          <p className="lead">
            A complete authentication solution for your React applications
          </p>
          {!isLoggedIn && (
            <div className="mt-4">
              <Button as={Link} to="/login" variant="primary" className="me-2">
                Log In
              </Button>
              <Button as={Link} to="/register" variant="outline-primary">
                Register
              </Button>
            </div>
          )}
        </Col>
      </Row>
      <Row className="mb-5">
        <Col md={4} className="mb-4">
          <Card className="h-100">
            <Card.Body>
              <h5>Secure Authentication</h5>
              <p>JWT-based authentication with HTTP-only cookies and token refresh functionality</p>
            </Card.Body>
          </Card>
        </Col>
        <Col md={4} className="mb-4">
          <Card className="h-100">
            <Card.Body>
              <h5>React Context API</h5>
              <p>Global state management using React's Context API for authentication state</p>
            </Card.Body>
          </Card>
        </Col>
        <Col md={4} className="mb-4">
          <Card className="h-100">
            <Card.Body>
              <h5>Bootstrap UI</h5>
              <p>Clean and responsive UI built with React Bootstrap components</p>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
};

export default Home;
EOF

##############################################
# Create src/components/pages/ProtectedPage.jsx
##############################################
cat << 'EOF' > src/components/pages/ProtectedPage.jsx
// src/components/pages/ProtectedPage.jsx
import React from 'react';
import { Container, Card } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';

const ProtectedPage = () => {
  const { currentUser } = useAuth();

  return (
    <Container className="py-5">
      <h2>Protected Page</h2>
      <p className="lead">This content is only accessible to authenticated users.</p>
      <Card className="mt-4">
        <Card.Body>
          <Card.Title>Your User Information</Card.Title>
          <ul className="list-unstyled">
            <li><strong>Username:</strong> {currentUser.username}</li>
            <li><strong>Email:</strong> {currentUser.email}</li>
            <li><strong>Roles:</strong> {currentUser.roles?.join(', ') || 'No roles assigned'}</li>
          </ul>
        </Card.Body>
      </Card>
    </Container>
  );
};

export default ProtectedPage;
EOF

##############################################
# Create src/components/pages/Profile.jsx
##############################################
cat << 'EOF' > src/components/pages/Profile.jsx
// src/components/pages/Profile.jsx
import React, { useState } from 'react';
import { Container, Card, Row, Col, Form, Button, Alert } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';

const Profile = () => {
  const { currentUser } = useAuth();
  const [error, setError]       = useState('');
  const [success, setSuccess]   = useState('');
  const [loading, setLoading]   = useState(false);

  const handleUpdateProfile = (e) => {
    e.preventDefault();
    setError('');
    setSuccess('');
    setLoading(true);
    setTimeout(() => {
      setSuccess('Profile updated successfully!');
      setLoading(false);
    }, 1000);
  };

  return (
    <Container className="py-5">
      <h2>Your Profile</h2>
      <Row className="mt-4">
        <Col lg={4} className="mb-4">
          <Card>
            <Card.Body className="text-center">
              <div className="mb-3">
                <img
                  src={`https://ui-avatars.com/api/?name=${currentUser.username}&background=random&size=128`}
                  alt="Profile"
                  className="rounded-circle img-thumbnail"
                />
              </div>
              <h5>{currentUser.username}</h5>
              <p className="text-muted">{currentUser.email}</p>
              <div>
                {currentUser.roles?.map((role, idx) => (
                  <span key={idx} className="badge bg-primary me-1">{role}</span>
                ))}
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col lg={8}>
          <Card>
            <Card.Body>
              <h5 className="mb-4">Edit Profile</h5>
              {error && <Alert variant="danger">{error}</Alert>}
              {success && <Alert variant="success">{success}</Alert>}
              <Form onSubmit={handleUpdateProfile}>
                <Form.Group className="mb-3" controlId="profileUsername">
                  <Form.Label>Username</Form.Label>
                  <Form.Control type="text" defaultValue={currentUser.username} disabled />
                  <Form.Text className="text-muted">Username cannot be changed</Form.Text>
                </Form.Group>
                <Form.Group className="mb-3" controlId="profileEmail">
                  <Form.Label>Email</Form.Label>
                  <Form.Control type="email" defaultValue={currentUser.email} />
                </Form.Group>
                <Button variant="primary" type="submit" disabled={loading}>
                  {loading ? 'Updating...' : 'Update Profile'}
                </Button>
              </Form>
            </Card.Body>
          </Card>
          <Card className="mt-4">
            <Card.Body>
              <h5 className="mb-4">Change Password</h5>
              <Form>
                <Form.Group className="mb-3" controlId="currentPassword">
                  <Form.Label>Current Password</Form.Label>
                  <Form.Control type="password" />
                </Form.Group>
                <Form.Group className="mb-3" controlId="newPassword">
                  <Form.Label>New Password</Form.Label>
                  <Form.Control type="password" />
                </Form.Group>
                <Form.Group className="mb-3" controlId="confirmNewPassword">
                  <Form.Label>Confirm New Password</Form.Label>
                  <Form.Control type="password" />
                </Form.Group>
                <Button variant="outline-primary">Change Password</Button>
              </Form>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
};

export default Profile;
EOF

##############################################
# Create src/contexts/AuthContext.jsx
##############################################
cat << 'EOF' > src/contexts/AuthContext.jsx
// src/contexts/AuthContext.jsx
import React, { createContext, useState, useEffect, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import AuthService from '../services/auth.service';
import setupInterceptors from '../utils/setupInterceptors';

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [currentUser, setCurrentUser] = useState(undefined);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  const logOut = async () => {
    await AuthService.logout();
    setCurrentUser(undefined);
  };

  useEffect(() => {
    setupInterceptors(() => {
      logOut();
      navigate('/login', { replace: true });
    });

    const user = AuthService.getCurrentUser();
    if (user) {
      setCurrentUser(user);
    }
    setLoading(false);
  }, [navigate]);

  const logIn = async (username, password) => {
    const userData = await AuthService.login(username, password);
    setCurrentUser(userData);
    return userData;
  };

  const register = async (username, email, password) => {
    return await AuthService.register(username, email, password);
  };

  const value = {
    currentUser,
    isLoggedIn: !!currentUser,
    loading,
    logIn,
    logOut,
    register
  };

  return (
    <AuthContext.Provider value={value}>
      {!loading && children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);
EOF

##############################################
# Create src/services/auth.service.js
##############################################
cat << 'EOF' > src/services/auth.service.js
// src/services/auth.service.js
import api from './api.service';
import TokenService from './token.service';
import { AUTH_ENDPOINTS } from '../utils/constants';

class AuthService {
  async login(username, password) {
    try {
      const response = await api.post(AUTH_ENDPOINTS.LOGIN, { username, password });
      if (response.data.accessToken) {
        TokenService.setUser(response.data);
      }
      return response.data;
    } catch (error) {
      throw this.handleError(error);
    }
  }

  async logout() {
    try {
      await api.post(AUTH_ENDPOINTS.LOGOUT);
    } catch (error) {
      console.error("Logout error", error);
    } finally {
      TokenService.removeUser();
    }
  }

  async register(username, email, password) {
    try {
      return await api.post(AUTH_ENDPOINTS.REGISTER, { username, email, password });
    } catch (error) {
      throw this.handleError(error);
    }
  }

  handleError(error) {
    const message =
      (error.response && error.response.data && error.response.data.message) ||
      error.message ||
      error.toString();
    return new Error(message);
  }

  getCurrentUser() {
    return TokenService.getUser();
  }

  isLoggedIn() {
    const user = this.getCurrentUser();
    return !!user && !!user.accessToken;
  }
}

export default new AuthService();
EOF

##############################################
# Create src/services/api.service.js
##############################################
cat << 'EOF' > src/services/api.service.js
// src/services/api.service.js
import axios from 'axios';
import { API_URL } from '../utils/constants';

const api = axios.create({
  baseURL: API_URL,
  headers: { 'Content-Type': 'application/json' },
  withCredentials: true
});

export default api;
EOF

##############################################
# Create src/services/token.service.js
##############################################
cat << 'EOF' > src/services/token.service.js
// src/services/token.service.js
import { STORAGE_KEYS } from '../utils/constants';

class TokenService {
  getLocalRefreshToken() {
    const user = JSON.parse(localStorage.getItem(STORAGE_KEYS.USER));
    return user?.refreshToken;
  }

  getLocalAccessToken() {
    const user = JSON.parse(localStorage.getItem(STORAGE_KEYS.USER));
    return user?.accessToken;
  }

  updateLocalAccessToken(token) {
    const user = JSON.parse(localStorage.getItem(STORAGE_KEYS.USER));
    user.accessToken = token;
    localStorage.setItem(STORAGE_KEYS.USER, JSON.stringify(user));
  }

  getUser() {
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.USER));
  }

  setUser(user) {
    localStorage.setItem(STORAGE_KEYS.USER, JSON.stringify(user));
  }

  removeUser() {
    localStorage.removeItem(STORAGE_KEYS.USER);
  }

  getCookie(name) {
    const match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
    return match ? match[2] : null;
  }
}

export default new TokenService();
EOF

##############################################
# Create src/utils/setupInterceptors.js
##############################################
cat << 'EOF' > src/utils/setupInterceptors.js
// src/utils/setupInterceptors.js
import api from '../services/api.service';
import TokenService from '../services/token.service';
import { AUTH_ENDPOINTS } from './constants';

const setupInterceptors = (onUnauthorized) => {
  api.interceptors.request.use(
    (config) => {
      const token = TokenService.getLocalAccessToken();
      if (token) config.headers['Authorization'] = 'Bearer ' + token;
      return config;
    },
    (error) => Promise.reject(error)
  );

  api.interceptors.response.use(
    (res) => res,
    async (err) => {
      const originalConfig = err.config;
      if (originalConfig.url !== AUTH_ENDPOINTS.LOGIN && err.response) {
        if (err.response.status === 401 && !originalConfig._retry) {
          originalConfig._retry = true;
          try {
            const rs = await api.post(AUTH_ENDPOINTS.REFRESH_TOKEN);
            const { accessToken } = rs.data;
            TokenService.updateLocalAccessToken(accessToken);
            return api(originalConfig);
          } catch (_error) {
            if (onUnauthorized) onUnauthorized();
            return Promise.reject(_error);
          }
        }
      }
      return Promise.reject(err);
    }
  );
};

export default setupInterceptors;
EOF

##############################################
# Create src/utils/constants.js
##############################################
cat << 'EOF' > src/utils/constants.js
// src/utils/constants.js
export const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8080/api';

export const AUTH_ENDPOINTS = {
  LOGIN: \`\${API_URL}/auth/signin\`,
  REGISTER: \`\${API_URL}/auth/signup\`,
  LOGOUT: \`\${API_URL}/auth/signout\`,
  REFRESH_TOKEN: \`\${API_URL}/auth/refreshtoken\`
};

export const STORAGE_KEYS = {
  USER: 'user',
  ACCESS_TOKEN: 'access_token',
  REFRESH_TOKEN: 'refresh_token'
};
EOF

echo "Folder structure and content files created successfully!"

