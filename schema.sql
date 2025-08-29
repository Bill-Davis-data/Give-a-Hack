-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Contact method enum type
DO $$ BEGIN
    CREATE TYPE contact_method AS ENUM ('email', 'phone', 'both');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- Organizations table - For non-profits and companies
CREATE TABLE IF NOT EXISTS organizations (
    organization_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    primary_service_category VARCHAR(100),
    organization_type VARCHAR(100), -- 'non_profit', 'company', 'government'
    tax_id VARCHAR(20),
    website_url TEXT,
    contact_email VARCHAR(255),
    contact_phone VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(2),
    zip_code VARCHAR(10),
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Service categories
CREATE TABLE IF NOT EXISTS service_categories (
    category_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    parent_category_id UUID REFERENCES service_categories(category_id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Need table - For tracking identified needs from social media and other platforms
CREATE TABLE IF NOT EXISTS need (
    need_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    post_url TEXT,
    post_message TEXT,
    source_platform VARCHAR(100),
    poster_name VARCHAR(255),
    post_time TIMESTAMP WITH TIME ZONE,
    tags_included TEXT,
    identified_service TEXT,
    identified_categories TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Ticket status table - for tracking status and assignment/acceptance of individual tickets.
CREATE TABLE IF NOT EXISTS needs_ticket_status (
    need_id UUID NOT NULL,
    status VARCHAR(100) NOT NULL,
    accepted_by UUID DEFAULT NULL
);
