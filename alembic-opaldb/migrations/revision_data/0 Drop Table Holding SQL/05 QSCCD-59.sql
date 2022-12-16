-- Drop colunn and table Priority 
ALTER TABLE Appointment DROP COLUMN  PrioritySerNum;
ALTER TABLE AppointmentMH DROP COLUMN  PrioritySerNum;
ALTER TABLE AppointmentPending DROP COLUMN  PrioritySerNum;
ALTER TABLE AppointmentPendingMH DROP COLUMN  PrioritySerNum;
ALTER TABLE Task DROP COLUMN PrioritySerNum;
ALTER TABLE TaskMH DROP COLUMN PrioritySerNum;
DROP TABLE IF EXISTS Priority;