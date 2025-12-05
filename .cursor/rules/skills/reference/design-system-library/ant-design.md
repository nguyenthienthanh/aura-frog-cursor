# Ant Design - Implementation Guide

**Design System:** Ant Design v5+
**Based On:** Ant Design Language
**Platforms:** React, Vue (via ant-design-vue)
**Package:** `antd`, `@ant-design/icons`, `@ant-design/pro-components`

---

## Installation

```bash
# Core
npm install antd

# Icons
npm install @ant-design/icons

# Pro Components (enterprise features)
npm install @ant-design/pro-components

# For Next.js
npm install @ant-design/nextjs-registry
```

---

## Theme Setup

### Basic Configuration

```tsx
// theme/themeConfig.ts
import type { ThemeConfig } from 'antd';

export const themeConfig: ThemeConfig = {
  token: {
    colorPrimary: '#1677ff',
    colorSuccess: '#52c41a',
    colorWarning: '#faad14',
    colorError: '#ff4d4f',
    borderRadius: 6,
    fontFamily: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
  },
  components: {
    Button: {
      borderRadius: 6,
      controlHeight: 36,
    },
    Card: {
      borderRadiusLG: 8,
    },
  },
};
```

### ConfigProvider Setup

```tsx
import { ConfigProvider, App } from 'antd';
import { themeConfig } from '@/theme/themeConfig';

export function AntdProvider({ children }: { children: React.ReactNode }) {
  return (
    <ConfigProvider theme={themeConfig}>
      <App>{children}</App>
    </ConfigProvider>
  );
}
```

---

## Component Patterns

### Buttons

```tsx
import { Button, Space } from 'antd';
import { PlusOutlined, DeleteOutlined } from '@ant-design/icons';

<Button type="primary">Primary</Button>
<Button>Default</Button>
<Button type="dashed">Dashed</Button>
<Button type="text">Text</Button>
<Button type="link">Link</Button>
<Button danger>Danger</Button>
<Button type="primary" icon={<PlusOutlined />}>Add New</Button>
<Button type="primary" loading={isLoading}>Submit</Button>
```

### Forms

```tsx
import { Form, Input, Select, Checkbox, Button, message } from 'antd';

const [form] = Form.useForm();

<Form form={form} layout="vertical" onFinish={handleSubmit}>
  <Form.Item
    label="Email"
    name="email"
    rules={[
      { required: true, message: 'Please input your email!' },
      { type: 'email', message: 'Please enter a valid email!' },
    ]}
  >
    <Input placeholder="Enter email" />
  </Form.Item>

  <Form.Item>
    <Button type="primary" htmlType="submit">
      Submit
    </Button>
  </Form.Item>
</Form>
```

### Table

```tsx
import { Table, Tag, Space, Button } from 'antd';
import type { ColumnsType } from 'antd/es/table';

const columns: ColumnsType<User> = [
  { title: 'Name', dataIndex: 'name', key: 'name' },
  { title: 'Email', dataIndex: 'email', key: 'email' },
  {
    title: 'Status',
    dataIndex: 'status',
    render: (status) => (
      <Tag color={status === 'active' ? 'green' : 'red'}>
        {status.toUpperCase()}
      </Tag>
    ),
  },
];

<Table columns={columns} dataSource={users} rowKey="id" />
```

### Modal

```tsx
import { Modal, Button, Form, Input } from 'antd';

const [isModalOpen, setIsModalOpen] = useState(false);

<Modal
  title="Create User"
  open={isModalOpen}
  onOk={() => form.submit()}
  onCancel={() => setIsModalOpen(false)}
>
  <Form form={form} layout="vertical" onFinish={handleSubmit}>
    <Form.Item label="Name" name="name" rules={[{ required: true }]}>
      <Input />
    </Form.Item>
  </Form>
</Modal>
```

---

## Best Practices

### DO

```tsx
// Use token values for custom styling
const token = theme.useToken();
<div style={{ padding: token.paddingMD }}>

// Use Form with form instance
const [form] = Form.useForm();

// Use Space for consistent gaps
<Space size="middle">
  <Button>One</Button>
  <Button>Two</Button>
</Space>
```

### DON'T

```tsx
// Avoid hardcoded colors
<Button style={{ backgroundColor: '#1890ff' }} />  // BAD

// Avoid margin hacks
<Button style={{ marginRight: 8 }} />  // BAD, use Space
```

---

## Dark Mode

```tsx
import { ConfigProvider, theme } from 'antd';

const { darkAlgorithm, defaultAlgorithm } = theme;

<ConfigProvider
  theme={{
    algorithm: isDarkMode ? darkAlgorithm : defaultAlgorithm,
  }}
>
  {children}
</ConfigProvider>
```

---

**Last Updated:** 2025-12-04
**Ant Design Version:** 5.x
