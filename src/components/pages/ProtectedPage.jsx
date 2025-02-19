// src/components/pages/ProtectedPage.jsx
import React from 'react';
import { Container, Card } from 'react-bootstrap';
import { useAuth } from '../../hooks/useAuth'

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
