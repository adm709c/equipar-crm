-- Create tables for Equipar CRM

-- Services/Products
CREATE TABLE IF NOT EXISTS services (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  price NUMERIC NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Vendors/Salespeople
CREATE TABLE IF NOT EXISTS vendors (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Orders/Sales
CREATE TABLE IF NOT EXISTS orders (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  order_number INTEGER NOT NULL UNIQUE,
  client_name TEXT NOT NULL,
  vehicle_plate TEXT,
  vehicle_model TEXT,
  vehicle_type TEXT,
  origin TEXT,
  unit TEXT,
  vendor_id UUID REFERENCES vendors(id),
  total NUMERIC NOT NULL,
  status TEXT DEFAULT 'Concluída',
  observations TEXT,
  print_image BYTEA,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Expenses
CREATE TABLE IF NOT EXISTS expenses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  description TEXT NOT NULL,
  amount NUMERIC NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Goals
CREATE TABLE IF NOT EXISTS goals (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  vehicle_type TEXT,
  amount NUMERIC NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS (Row Level Security)
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendors ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE goals ENABLE ROW LEVEL SECURITY;

-- Create policies to allow public access (for frontend)
CREATE POLICY "Enable read access" ON services FOR SELECT USING (true);
CREATE POLICY "Enable read access" ON vendors FOR SELECT USING (true);
CREATE POLICY "Enable read access" ON orders FOR SELECT USING (true);
CREATE POLICY "Enable read access" ON expenses FOR SELECT USING (true);
CREATE POLICY "Enable read access" ON goals FOR SELECT USING (true);

CREATE POLICY "Enable insert access" ON services FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable insert access" ON vendors FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable insert access" ON orders FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable insert access" ON expenses FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable insert access" ON goals FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable update access" ON orders FOR UPDATE USING (true);
CREATE POLICY "Enable update access" ON vendors FOR UPDATE USING (true);

CREATE POLICY "Enable delete access" ON orders FOR DELETE USING (true);
CREATE POLICY "Enable delete access" ON vendors FOR DELETE USING (true);
CREATE POLICY "Enable delete access" ON services FOR DELETE USING (true);
