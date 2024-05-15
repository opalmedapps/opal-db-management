INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES
(6085,	9,	4,	51,	'H',	NULL,	'2023-01-04 20:59:00',	'2023-01-04 21:43:33',	0.9,	1.1,	'0.90-1.10',	4.8,	'4.80',	'',	'2023-01-05 10:37:27',	0,	'[]',	'2023-01-05 15:37:27',  '2023-01-04 21:43:33'),
(6086,	9,	5,	51,	'H',	NULL,	'2023-01-04 20:59:00',	'2023-01-04 21:43:33',	11.9,	14.7,	'11.9-14.7',	44.6,	'44.6',	's',	'2023-01-05 10:37:27',	0,	'[]',	'2023-01-05 15:37:27',  '2023-01-04 21:43:33'),
(6087,	9,	6,	51,	'H',	NULL,	'2023-01-04 20:59:00',	'2023-01-04 21:43:33',	29.1,	42.2,	'29.1-42.2',	80.1,	'80.1',	's',	'2023-01-05 10:37:27',	0,	'[]',	'2023-01-05 15:37:27',  '2023-01-04 21:43:33'),
(6886,	9,	4,	51,	'H',	NULL,	'2023-01-05 10:59:00',	'2023-01-05 10:43:33',	0.9,	1.1,	'0.90-1.10',	4.8,	'4.80',	'',	'2023-01-05 11:22:25',	0,	'[]',	'2032-01-05 16:22:25',  '2023-01-05 10:43:33'),
(6887,	9,	5,	51,	'H',	NULL,	'2023-01-05 10:59:00',	'2023-01-05 10:43:33',	11.9,	14.7,	'11.9-14.7',	44.6,	'44.6',	's',	'2023-01-05 11:22:25',	0,	'[]',	'2023-01-05 16:22:25',  '2023-01-05 10:43:33'),
(6888,	9,	6,	52,	'H',	NULL,	'2023-01-05 10:59:00',	'2023-01-05 10:43:33',	29.1,	42.2,	'29.1-42.2',	80.1,	'80.1',	's',	'2023-01-05 11:22:25',	0,	'[]',	'2023-01-05 16:22:25',  '2023-01-05 10:43:33'),
(6889,	7,	101,	52,	'H',	NULL,	'2023-03-04 04:37:00',	'2023-03-04 05:37:00',	6,	45,	'6-45',	189,	'189',	'U/L',	'2023-01-05 11:25:46',	0,	'[]',	'2023-01-05 16:25:46',  '2023-03-04 05:37:00'),
(6890,	7,	102,	52,	'H',	NULL,	'2023-03-04 04:37:00',	'2023-03-04 05:37:00',	56,	120,	'56-120',	493,	'493',	'U/L',	'2023-01-05 11:25:46',	0,	'[]',	'2023-01-05 16:25:46',  '2023-03-04 05:37:00'),
(6891,	68,	8,	52,	'',	NULL,	'2023-03-04 05:37:00',	'2023-03-04 05:37:00',	133,	143,	'133-143',	136,	'136',	'mmol/L',	'2023-01-05 11:30:12',	0,	'[]',	'2023-01-05 16:30:12',  '2023-03-04 05:37:00'),
(6895,	70,	84,	51,	'L',	NULL,	'2023-05-05 10:00:00',	'2023-05-05 10:00:00',	0.8,	1.45,	'0.80-1.45',	0.68,	'0.68',	'mmol/L',	'2023-01-05 12:43:31',	0,	'[]',	'2023-01-05 17:43:31',  '2023-05-05 10:00:00');


-- Additional test results for marge for databank testing
INSERT INTO `PatientTestResult` VALUES (3720935, 4, 62, 51, 'C', 1, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 4, 11, '4.00-11.00', 30, '30.00', '10^9/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720936, 4, 63, 51, 'H', 1, '2022-06-19 07:54:00', '2022-03-30 09:23:55', 4, 5, '4-5', 15, '15', '10^12/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-03-30 09:23:55');
INSERT INTO `PatientTestResult` VALUES (3720937, 4, 64, 51, 'C', 2, '2022-06-19 07:54:00', '2022-03-30 09:23:55', 120, 160, '120-160', 50, '50', 'g/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-03-30 09:23:55');
INSERT INTO `PatientTestResult` VALUES (3720938, 4, 66, 51, '', 4, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 82, 100, '82.0-100.0', 100, '100.0', 'fL', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720939, 4, 67, 51, '', 5, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 27, 31, '27.0-31.0', 31, '31.0', 'pg/cell', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720940, 4, 68, 51, '', 6, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 320, 360, '320-360', 360, '360', 'g/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720941, 4, 69, 51, '', 7, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 12.7, 16, '12.7-16.0', 16, '16.0', 'cV', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720942, 4, 70, 51, '', 8, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 140, 440, '140-440', 440, '440', '10^9/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720943, 4, 1362, 51, '', 9, '2022-06-19 07:54:00', '2022-06-19 08:43:08', NULL, NULL, '', 5, '5.000', '', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720944, 4, 71, 51, '', 10, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 7.4, 10.7, '7.4-10.7', 10, '10.0', 'fL', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720945, 4, 1361, 51, '', 11, '2022-06-19 07:54:00', '2022-06-19 08:43:08', NULL, NULL, '', 5, '5.0', 'cV', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720946, 4, 79, 51, '', 12, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 0.8, 4.4, '0.80-4.40', 4, '4.00', '10^9/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720947, 4, 80, 51, 'H', 13, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 0.08, 0.88, '0.08-0.88', 1, '1.00', '10^9/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720948, 4, 78, 51, '', 14, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 1.6, 7.7, '1.60-7.70', 7, '7.00', '10^9/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720949, 4, 81, 51, 'H', 15, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 0, 0.5, '0.00-0.50', 1, '1.00', '10^9/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720950, 4, 82, 51, 'H', 16, '2022-06-19 07:54:00', '2022-06-19 08:43:08', 0, 0.22, '0.00-0.22', 1, '1.00', '10^9/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720951, 4, 83, 51, '', 17, '2022-06-19 07:54:00', '2022-06-19 08:43:08', NULL, NULL, '', 5, '5.00', '10^9/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-06-19 08:43:08');
INSERT INTO `PatientTestResult` VALUES (3720934, 202, 302, 51, '', 1, '2022-11-14 11:51:00', '2022-11-14 14:42:51', 1.5, 9.3, '1.5-9.3', 5.3, '5.3', 'pmol/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-11-14 14:42:51');
INSERT INTO `PatientTestResult` VALUES (3720933, 337, 91, 51, 'L', 1, '2022-05-09 12:34:00', '2022-03-30 09:23:21', 40, 85, '40-85', 9, '9', 'umol/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-03-30 09:23:21');
INSERT INTO `PatientTestResult` VALUES (7037296, 478, 182, 51, 'H', 1, '2022-05-09 12:34:00', '2022-05-09 12:35:21', 0.1, 1.7, '0.10-1.70', 2.1, '2.10', 'mmol/L', '2022-07-22 15:05:52', 0, '[]', '2023-07-22 15:05:52', '2022-05-09 12:35:21');
INSERT INTO `PatientTestResult` VALUES (7037294, 478, 182, 51, 'H', 0, '2022-05-09 12:42:00', '2022-05-09 12:43:17', 0.1, 1.7, '0.10-1.70', 2, '2.00', 'mmol/L', '2022-07-22 15:05:52', 0, '[]', '2023-07-22 15:05:52', '2022-05-09 12:43:17');
INSERT INTO `PatientTestResult` VALUES (7037293, 458, 1171, 51, '', 1, '2022-08-09 10:06:00', '2022-08-09 10:07:08', 1, 2.6, '1.0-2.6', 2.5, '2.5', 'nmol/L', '2022-07-22 15:05:52', 0, '[]', '2023-07-22 15:05:52', '2022-08-09 10:07:08');
INSERT INTO `PatientTestResult` VALUES (7037292, 458, 1171, 51, '', 1, '2022-08-09 10:30:00', '2022-08-09 10:31:02', 1, 2.6, '1.0-2.6', 2.4, '2.4', 'nmol/L', '2022-07-22 15:05:52', 0, '[]', '2023-07-22 15:05:52', '2022-08-09 10:31:02');
INSERT INTO `PatientTestResult` VALUES (7037291, 458, 1171, 51, '', 0, '2022-08-09 10:36:00', '2022-08-09 10:40:35', 1, 2.6, '1.0-2.6', 1, '1.0', 'nmol/L', '2022-07-22 15:05:52', 0, '[]', '2023-07-22 15:05:52', '2022-08-09 10:40:35');
INSERT INTO `PatientTestResult` VALUES (7037290, 458, 1171, 51, '', 1, '2022-08-09 10:37:00', '2022-08-09 10:37:28', 1, 2.6, '1.0-2.6', 1.2, '1.2', 'nmol/L', '2022-07-22 15:05:52', 0, '[]', '2023-07-22 15:05:52', '2022-08-09 10:37:28');
INSERT INTO `PatientTestResult` VALUES (3720929, 10, 294, 51, '', 1, '2022-10-18 08:11:00', '2022-10-18 08:12:43', 3.3, 19.4, '3.3-19.4', 3.3, '3.3', 'mg/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-10-18 08:12:43');
INSERT INTO `PatientTestResult` VALUES (3720930, 10, 295, 51, '', 2, '2022-10-18 08:11:00', '2022-10-18 08:12:43', 5.7, 26.3, '5.7-26.3', 5.7, '5.7', 'mg/L', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-10-18 08:12:43');
INSERT INTO `PatientTestResult` VALUES (3720931, 10, 296, 51, '', 3, '2022-10-18 08:11:00', '2022-10-18 08:12:43', 0.26, 1.65, '0.26-1.65', 0.58, '0.58', '', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-10-18 08:12:43');
INSERT INTO `PatientTestResult` VALUES (3720932, 10, 297, 51, '', 4, '2022-10-18 08:11:00', '2022-10-18 08:12:43', NULL, NULL, '', NULL, 'Sérum normal. Normal serum. Dr. A. Baass', '', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-10-18 08:12:43');
INSERT INTO `PatientTestResult` VALUES (3720926, 136, 1146, 51, '', 1, '2022-01-21 14:56:00', '2022-01-21 15:35:44', NULL, NULL, '', NULL, 'Positive, patient should be referred for Colposcopy', '', '2022-01-25 03:37:04', 0, '[]', '2023-01-25 03:37:04', '2022-01-21 15:35:44');

-- extra results for flintstones
-- pebbles blood profile
INSERT INTO `PatientTestResult` VALUES (4000001, 4, 62, 57, '', 1, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 4, 11, '4.00-11.00', 8, '8.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000002, 4, 63, 57, 'L', 2, '2023-10-15 07:54:00', '2023-10-15 09:23:55', 4, 5, '4-5', 3, '3.00', '10^12/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 09:23:55');
INSERT INTO `PatientTestResult` VALUES (4000003, 4, 64, 57, 'C', 3, '2023-10-15 07:54:00', '2023-10-15 09:23:55', 120, 160, '120-160', 50, '50', 'g/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 09:23:55');
INSERT INTO `PatientTestResult` VALUES (4000004, 4, 66, 57, '', 4, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 82, 100, '82.0-100.0', 70, '70.0', 'fL', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000005, 4, 67, 57, 'H', 5, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 27, 31, '27.0-31.0', 34, '34.0', 'pg/cell', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000006, 4, 68, 57, '', 6, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 320, 360, '320-360', 360, '360', 'g/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000007, 4, 69, 57, '', 7, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 12.7, 16, '12.7-16.0', 16, '16.0', 'cV', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000008, 4, 70, 57, '', 8, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 140, 440, '140-440', 440, '440', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000009, 4, 1362, 57, '', 9, '2023-10-15 07:54:00', '2023-10-15 08:43:08', NULL, NULL, '', 5, '5.000', '', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000010, 4, 71, 57, '', 10, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 7.4, 10.7, '7.4-10.7', 10, '10.0', 'fL', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000011, 4, 1361, 57, '', 11, '2023-10-15 07:54:00', '2023-10-15 08:43:08', NULL, NULL, '', 5, '5.0', 'cV', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000012, 4, 79, 57, '', 12, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 0.8, 4.4, '0.80-4.40', 4, '4.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000013, 4, 80, 57, 'H', 13, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 0.08, 0.88, '0.08-0.88', 1, '1.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000014, 4, 78, 57, '', 14, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 1.6, 7.7, '1.60-7.70', 7, '7.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000015, 4, 81, 57, 'H', 15, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 0, 0.5, '0.00-0.50', 1, '1.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000016, 4, 82, 57, 'H', 16, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 0, 0.22, '0.00-0.22', 1, '1.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000017, 4, 83, 57, '', 17, '2023-10-15 07:54:00', '2023-10-15 08:43:08', NULL, NULL, '', 5, '5.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
-- fred chem7
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES
(7037297,	479,	8,	56,	'',	1,	'2023-10-17 11:52:00',	'2023-10-17 13:44:12',	133,	143,	'133-143',	136,	'136',	'mmol/L',	'2023-11-07 21:04:53',	0,	'[]',	'2023-11-07 16:04:59',	'2023-10-17 13:44:12'),
(7037298,	479,	86,	56,	'L',	2,	'2023-10-17 11:52:00',	'2023-10-17 13:44:12',	3.5,	5,	'3.5-5.0',	3.2,	'3.2',	'mmol/L',	'2023-11-07 21:04:53',	0,	'[]',	'2023-11-07 16:04:59',	'2023-10-17 13:44:12'),
(7037299,	479,	87,	56,	'',	3,	'2023-10-17 11:52:00',	'2023-10-17 13:44:12',	100,	109,	'100-109',	102,	'102',	'mmol/L',	'2023-11-07 21:04:53',	0,	'[]',	'2023-11-07 16:04:59',	'2023-10-17 13:44:12'),
(7037300,	479,	88,	56,	'',	4,	'2023-10-17 11:52:00',	'2023-10-17 13:44:12',	23,	29,	'23-29',	25,	'25',	'mmol/L',	'2023-11-07 21:04:53',	0,	'[]',	'2023-11-07 16:04:59',	'2023-10-17 13:44:12'),
(7037301,	479,	89,	56,	'',	5,	'2023-10-17 11:52:00',	'2023-10-17 13:44:12',	3,	13,	'3-13',	9,	'9',	'mmol/L',	'2023-11-07 21:04:53',	0,	'[]',	'2023-11-07 16:04:59',	'2023-10-17 13:44:12'),
(7037302,	479,	90,	56,	'',	6,	'2023-10-17 11:52:00',	'2023-10-17 13:44:12',	3.9,	11,	'3.9-11.0',	7,	'7.0',	'mmol/L',	'2023-11-07 21:04:53',	0,	'[]',	'2023-11-07 16:04:59',	'2023-10-17 13:44:12'),
(7037303,	479,	91,	56,	'',	7,	'2023-10-17 11:52:00',	'2023-10-17 13:44:12',	40,	85,	'40-85',	79,	'79',	'umol/L',	'2023-11-07 21:04:53',	0,	'[]',	'2023-11-07 16:04:59',	'2023-10-17 13:44:12');

-- wednesday blood profile
INSERT INTO `PatientTestResult` VALUES (4000018, 4, 62, 58, '', 1, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 4, 11, '4.00-11.00', 8, '8.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000019, 4, 63, 58, 'L', 2, '2023-10-15 07:54:00', '2023-10-15 09:23:55', 4, 5, '4-5', 3, '3.00', '10^12/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 09:23:55');
INSERT INTO `PatientTestResult` VALUES (4000020, 4, 64, 58, 'C', 3, '2023-10-15 07:54:00', '2023-10-15 09:23:55', 120, 160, '120-160', 50, '50', 'g/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 09:23:55');
INSERT INTO `PatientTestResult` VALUES (4000021, 4, 66, 58, '', 4, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 82, 100, '82.0-100.0', 70, '70.0', 'fL', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000022, 4, 67, 58, 'H', 5, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 27, 31, '27.0-31.0', 34, '34.0', 'pg/cell', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000023, 4, 68, 58, '', 6, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 320, 360, '320-360', 360, '360', 'g/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000024, 4, 69, 58, '', 7, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 12.7, 16, '12.7-16.0', 16, '16.0', 'cV', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000025, 4, 70, 58, '', 8, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 140, 440, '140-440', 440, '440', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000026, 4, 1362, 58, '', 9, '2023-10-15 07:54:00', '2023-10-15 08:43:08', NULL, NULL, '', 5, '5.000', '', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000027, 4, 71, 58, '', 10, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 7.4, 10.7, '7.4-10.7', 10, '10.0', 'fL', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000028, 4, 1361, 58, '', 11, '2023-10-15 07:54:00', '2023-10-15 08:43:08', NULL, NULL, '', 5, '5.0', 'cV', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000029, 4, 79, 58, '', 12, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 0.8, 4.4, '0.80-4.40', 4, '4.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000030, 4, 80, 58, 'H', 13, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 0.08, 0.88, '0.08-0.88', 1, '1.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000031, 4, 78, 58, '', 14, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 1.6, 7.7, '1.60-7.70', 7, '7.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000032, 4, 81, 58, 'H', 15, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 0, 0.5, '0.00-0.50', 1, '1.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000033, 4, 82, 58, 'H', 16, '2023-10-15 07:54:00', '2023-10-15 08:43:08', 0, 0.22, '0.00-0.22', 1, '1.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');
INSERT INTO `PatientTestResult` VALUES (4000034, 4, 83, 58, '', 17, '2023-10-15 07:54:00', '2023-10-15 08:43:08', NULL, NULL, '', 5, '5.00', '10^9/L', '2023-10-21 08:43:08', 0, '[]', '2023-10-21 08:43:08', '2023-10-15 08:43:08');

-- Lisa Urinalysis Nephrology. TODO: Create separate OHIGPH/OMI Test result folders?
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037304, 480, 9, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, '-', NULL, 'Limpide', '', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037305, 480, 10, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, '-', NULL, 'Jaune Pâle', '', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037306, 480, 11, 54, 'L', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', 1.015, 1.025, '1.015-1.025', 1.005, '1.005', '', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037307, 480, 12, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, 'Négatif-', NULL, 'Négatif', '', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037308, 480, 13, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, 'Négatif-', NULL, 'Approx.25', '', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037309, 480, 14, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, 'Négatif-', NULL, 'Négatif', 'mmol/L', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037310, 480, 15, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, 'Négatif-', NULL, 'Négatif', 'mmol/L', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037311, 480, 16, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, 'Négatif-', NULL, 'Négatif', '', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037312, 480, 17, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, 'Négatif-', NULL, 'Négatif', '', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037313, 480, 18, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, '-', NULL, '<=5.0', '', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037314, 480, 19, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, 'Négatif-', NULL, 'Négatif', 'g/L', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037315, 480, 20, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:33', NULL, NULL, 'Négatif-', NULL, 'Négatif', 'umol/L', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:33');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037316, 480, 21, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:34', NULL, NULL, '3-5-', NULL, 'Non observé', '/HPF', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:34');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037317, 480, 22, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:34', NULL, NULL, '3-5-', NULL, 'Non observé', '/HPF', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:34');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037318, 480, 23, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:34', NULL, NULL, '-', NULL, 'Non observé', '/HPF', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:34');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037319, 480, 24, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:34', NULL, NULL, 'Non observé-', NULL, 'Non observé', '/HPF', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:34');
INSERT INTO `PatientTestResult` (`PatientTestResultSerNum`, `TestGroupExpressionSerNum`, `TestExpressionSerNum`, `PatientSerNum`, `AbnormalFlag`, `SequenceNum`, `CollectedDateTime`, `ResultDateTime`, `NormalRangeMin`, `NormalRangeMax`, `NormalRange`, `TestValueNumeric`, `TestValue`, `UnitDescription`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`, `AvailableAt`) VALUES (7037320, 480, 25, 54, '', NULL, '2024-05-10 08:01:00', '2024-05-10 09:55:34', NULL, NULL, '-', NULL, 'Non observé', '/HPF', '2024-05-10 10:24:27', 0, '[]', '2024-05-10 10:24:28', '2024-05-10 09:55:34');


-- Mark all initial PatientTestResults as read
-- Marge's data read by Marge
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 51
;

-- Homer's data read by Homer and Marge
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["PyKlcbRpMLVm8lVnuopFnFOHO4B3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 52
;

-- Bart's data read by Bart
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["SipDLZCcOyTYj7O3C8HnWLalb4G3"]'
WHERE PatientSerNum = 53
;

-- Fred's data read by Fred
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["ZYHAjhNy6hhr4tOW8nFaVEeKngt1"]'
WHERE PatientSerNum = 56
;

-- Pebbles' data read by Fred
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["ZYHAjhNy6hhr4tOW8nFaVEeKngt1"]'
WHERE PatientSerNum = 57
;

-- Wednesday's data read by no one (no relationships in Django)

-- Lisas data read by Marge and received 12 days ago
UPDATE PatientTestResult
SET
CollectedDateTime = DATE_ADD(now(), INTERVAL -12 DAY),
ResultDateTime = DATE_ADD(now(), INTERVAL -12 DAY),
DateAdded = DATE_ADD(now(), INTERVAL -12 DAY),
LastUpdated = DATE_ADD(now(), INTERVAL -12 DAY),
AvailableAt = DATE_ADD(now(), INTERVAL -12 DAY),
ReadStatus = 1,
ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 54
;
