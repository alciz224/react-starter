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
