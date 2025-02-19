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
