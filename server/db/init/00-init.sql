ALTER SYSTEM SET wal_level='logical';
ALTER SYSTEM SET max_wal_senders='10';
ALTER SYSTEM SET max_replication_slots='10';

-- Create the Replication publication
CREATE PUBLICATION supabase_realtime FOR ALL TABLES;
