-- Sample data for AltruJAX database
-- This file contains insert statements for all tables with realistic sample data

-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Insert sample organizations
INSERT INTO organizations (
    name,
    description,
    primary_service_category,
    organization_type,
    website_url,
    contact_email,
    contact_phone,
    address,
    city,
    state,
    zip_code
) VALUES
-- Food/Grocery
('Second Harvest North Florida', 'A food bank distributing millions of pounds of food annually to partner agencies across 16 counties.', 'food/grocery', 'non_profit', 'https://www.wenourishhope.org', NULL, NULL, NULL, 'Jacksonville', 'FL', '32206'),
('Feeding Northeast Florida', 'Works to alleviate hunger by rescuing food and distributing it to those in need.', 'food/grocery', 'non_profit', 'https://feedingnefl.org', NULL, NULL, NULL, 'Jacksonville', 'FL', '32206'),
-- Mental Health
('CNS Healthcare', 'Provides mental health services, including therapy and support, to individuals in Northeast Florida.', 'mental health', 'non_profit', 'https://thestarr.org/cnshc-jacksonville/', NULL, NULL, NULL, 'Jacksonville', 'FL', '32207'),
('Brothers Fighting Against Mental Health', 'Raises awareness and provides support for mental health issues affecting men.', 'mental health', 'non_profit', 'https://www.brothersfighting.org', NULL, NULL, NULL, 'Jacksonville', 'FL', '32256'),
-- Home/Shelter
('Sulzbacher Center', 'Provides comprehensive services, including shelter and healthcare, to the homeless population.', 'home/shelter', 'non_profit', 'https://sulzbacherjax.org', NULL, NULL, NULL, 'Jacksonville', 'FL', '32206'),
('Clara White Mission', 'Offers transitional housing and job training to homeless individuals.', 'home/shelter', 'non_profit', 'https://clarawhitemission.org', NULL, NULL, NULL, 'Jacksonville', 'FL', '32206'),
('New Directions Warming & Cooling Center', 'Provides temporary shelter and meals to individuals in need during extreme weather conditions.', 'home/shelter', 'non_profit', 'https://www.newdirectionsjax.org', NULL, NULL, NULL, 'Jacksonville', 'FL', '32202'),
('Mission House','Empowers individuals affected by homelessness in the Beaches area through food, clothing, medical care, and support services aimed at helping them regain self-sufficiency.','home/shelter','non_profit','https://missionhousejax.org','info@missionhousejax.org','(904) 241-6767','800 Shetter Ave','Jacksonville Beach','FL','32250'),
-- Transportation
('Angel Flight Southeast', 'Offers free air transportation to medical patients and their families.', 'transportation', 'non_profit', 'https://www.angelflightse.org', NULL, NULL, NULL, 'Jacksonville', 'FL', '32218'),
-- Financial
('Catholic Charities Jacksonville', 'Provides emergency financial assistance to individuals and families in crisis.', 'financial', 'non_profit', 'https://www.ccbjax.org/emergency-financial-assistance', NULL, NULL, NULL, 'Jacksonville', 'FL', '32204'),
('Operation New Hope', 'Offers financial literacy programs and employment services to individuals re-entering society.', 'financial', 'non_profit', 'https://www.operationnewhope.com', NULL, NULL, NULL, 'Jacksonville', 'FL', '32206'),
-- Caretaking
('Community Hospice & Palliative Care', 'Provides end-of-life care and support to patients and their families.', 'caretaking', 'non_profit', 'https://www.communityhospice.com', NULL, NULL, NULL, 'Jacksonville', 'FL', '32207'),
('The Church of Eleven22', 'Offers emergency services and long-term recovery programs to individuals in need.', 'caretaking', 'non_profit', 'https://coe22.com/care/assistance/', NULL, NULL, NULL, 'Jacksonville', 'FL', '32210'),
-- Veterans
('Five STAR Veterans Center', 'Assists veterans with reintegration into society, focusing on mental health and housing.', 'veterans', 'non_profit', 'https://www.5starveteranscenter.org', NULL, NULL, NULL, 'Jacksonville', 'FL', '32209'),
('Wounded Warrior Project', 'Provides support and services to wounded veterans and their families.', 'veterans', 'non_profit', 'https://www.woundedwarriorproject.org', NULL, NULL, NULL, 'Jacksonville', 'FL', '32256');


-- Insert sample service categories
INSERT INTO service_categories (category_id, name, description, parent_category_id, is_active, created_at) VALUES
    ('990e8400-e29b-41d4-a716-446655440001', 'Food/Grocery', NULL, NULL, true, '2024-01-01 00:00:00+00'),
    ('990e8400-e29b-41d4-a716-446655440011', 'Mental Health', NULL, NULL, true, '2024-01-01 00:00:00+00'),
    ('990e8400-e29b-41d4-a716-446655440012', 'Home/Shelter', NULL, NULL, true, '2024-01-01 00:00:00+00'),
    ('990e8400-e29b-41d4-a716-446655440013', 'Transportation', NULL, NULL, true, '2024-01-01 00:00:00+00'),
    ('990e8400-e29b-41d4-a716-446655440014', 'Financial', NULL, NULL, true, '2024-01-01 00:00:00+00'),
    ('990e8400-e29b-41d4-a716-446655440015', 'Caretaking', NULL, NULL, true, '2024-01-01 00:00:00+00'),
    ('990e8400-e29b-41d4-a716-446655440016', 'Veterans', NULL, NULL, true, '2024-01-01 00:00:00+00');


--  Insert sample ticket status records
-- First, assign the first 85 need_ids to 'Completed',
-- next 10 to 'Accepted', next 4 to 'Received'
INSERT INTO needs_ticket_status (need_id, status)
SELECT need_id, 'Completed'
FROM need
ORDER BY need_id
LIMIT 85;

INSERT INTO needs_ticket_status (need_id, status)
SELECT need_id, 'Accepted'
FROM need
WHERE need_id NOT IN (SELECT need_id FROM needs_ticket_status)
ORDER BY need_id
LIMIT 10;

INSERT INTO needs_ticket_status (need_id, status)
SELECT need_id, 'Received'
FROM need
WHERE need_id NOT IN (SELECT need_id FROM needs_ticket_status)
ORDER BY need_id
LIMIT 4;

-- Update needs_ticket_status.accepted_by with a random matching organization_id
UPDATE needs_ticket_status ns
SET accepted_by = sub.organization_id
FROM (
    SELECT n.need_id,
           (
               SELECT o.organization_id
               FROM organizations o
               WHERE o.primary_service_category = n.identified_categories
               ORDER BY random()
               LIMIT 1
           ) AS organization_id
    FROM need n
) sub
WHERE ns.need_id = sub.need_id
	AND ns.status <> 'Received';
