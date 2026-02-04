-- 00_create_databases.sql
-- Sentiric Platformu için Mantıksal Veritabanı Tanımları

-- 1. Çekirdek Servis Veritabanları
SELECT 'CREATE DATABASE sentiric_user' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_user')\gexec
SELECT 'CREATE DATABASE sentiric_dialplan' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_dialplan')\gexec
SELECT 'CREATE DATABASE sentiric_agent' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_agent')\gexec
SELECT 'CREATE DATABASE sentiric_cdr' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_cdr')\gexec
SELECT 'CREATE DATABASE sentiric_knowledge' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_knowledge')\gexec

-- 2. Dikey İş Servisleri (Verticals)
SELECT 'CREATE DATABASE sentiric_vertical_hospitality' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_vertical_hospitality')\gexec
SELECT 'CREATE DATABASE sentiric_vertical_health' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_vertical_health')\gexec
SELECT 'CREATE DATABASE sentiric_vertical_finance' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_vertical_finance')\gexec
SELECT 'CREATE DATABASE sentiric_vertical_legal' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_vertical_legal')\gexec
SELECT 'CREATE DATABASE sentiric_vertical_ecommerce' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_vertical_ecommerce')\gexec
SELECT 'CREATE DATABASE sentiric_vertical_public' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_vertical_public')\gexec
SELECT 'CREATE DATABASE sentiric_vertical_insurance' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sentiric_vertical_insurance')\gexec