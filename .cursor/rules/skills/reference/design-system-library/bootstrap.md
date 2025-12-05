# Bootstrap - Implementation Guide

**Design System:** Bootstrap v5.3+
**Type:** CSS Framework
**Platforms:** All (React, Vue, Angular, vanilla HTML)
**Package:** `bootstrap`, `react-bootstrap`, `bootstrap-vue-next`

---

## Installation

### React (react-bootstrap)

```bash
npm install react-bootstrap bootstrap
```

### Setup

```tsx
// main.tsx or App.tsx
import 'bootstrap/dist/css/bootstrap.min.css';
```

---

## Component Patterns

### Buttons

```tsx
import { Button, ButtonGroup } from 'react-bootstrap';

<Button variant="primary">Primary</Button>
<Button variant="secondary">Secondary</Button>
<Button variant="outline-primary">Outline Primary</Button>
<Button size="lg">Large</Button>
<Button size="sm">Small</Button>
<Button disabled>Disabled</Button>
```

### Forms

```tsx
import { Form, FloatingLabel, Button } from 'react-bootstrap';

<Form onSubmit={handleSubmit}>
  <Form.Group className="mb-3" controlId="email">
    <Form.Label>Email address</Form.Label>
    <Form.Control
      type="email"
      placeholder="name@example.com"
      isInvalid={!!errors.email}
    />
    <Form.Control.Feedback type="invalid">
      {errors.email}
    </Form.Control.Feedback>
  </Form.Group>

  <Button variant="primary" type="submit">
    Submit
  </Button>
</Form>
```

### Cards

```tsx
import { Card, Button } from 'react-bootstrap';

<Card style={{ width: '18rem' }}>
  <Card.Img variant="top" src="/image.jpg" />
  <Card.Body>
    <Card.Title>Card Title</Card.Title>
    <Card.Text>
      Some quick example text.
    </Card.Text>
    <Button variant="primary">Go somewhere</Button>
  </Card.Body>
</Card>
```

### Modals

```tsx
import { Modal, Button } from 'react-bootstrap';

const [show, setShow] = useState(false);

<Modal show={show} onHide={() => setShow(false)} centered>
  <Modal.Header closeButton>
    <Modal.Title>Modal Title</Modal.Title>
  </Modal.Header>
  <Modal.Body>
    Modal content goes here.
  </Modal.Body>
  <Modal.Footer>
    <Button variant="secondary" onClick={() => setShow(false)}>
      Cancel
    </Button>
    <Button variant="primary" onClick={handleSave}>
      Save Changes
    </Button>
  </Modal.Footer>
</Modal>
```

### Layout

```tsx
import { Container, Row, Col } from 'react-bootstrap';

<Container>
  <Row>
    <Col xs={12} md={6} lg={4}>Responsive</Col>
    <Col xs={12} md={6} lg={8}>Columns</Col>
  </Row>
</Container>
```

---

## Utility Classes

### Spacing

```html
<div class="m-3">margin all sides</div>
<div class="mt-3">margin top</div>
<div class="p-3">padding all sides</div>
<div class="mx-auto">center horizontally</div>
```

### Display & Flex

```html
<div class="d-flex justify-content-between align-items-center">
  <span>Left</span>
  <span>Right</span>
</div>

<div class="d-none d-md-block">Hidden on mobile</div>
```

---

## Responsive Breakpoints

- `xs`: < 576px
- `sm`: >= 576px
- `md`: >= 768px
- `lg`: >= 992px
- `xl`: >= 1200px
- `xxl`: >= 1400px

---

## Best Practices

### DO

```tsx
// Use utility classes for common styling
<div className="d-flex justify-content-between align-items-center p-3">

// Use variants consistently
<Button variant="primary">
<Alert variant="danger">
```

### DON'T

```tsx
// Don't mix inline styles with Bootstrap classes
<div style={{ marginTop: '20px' }} className="mb-3">  // BAD
```

---

**Last Updated:** 2025-12-04
**Bootstrap Version:** 5.3.x
