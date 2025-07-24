-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
-- rory: treatment guidelines, databank info
(17, NULL, 105, 59, '2025-05-23 14:40:13', 0, '["mouj1pqpXrYCl994oSm5wtJT3In2"]', '2025-05-23 14:40:13'),
(18, NULL, 979, 59, '2025-04-02 14:40:13', 0, '["mouj1pqpXrYCl994oSm5wtJT3In2"]', '2025-04-02 14:40:13');

-- laurie data
INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(20, NULL, 8, 92, '2016-05-06 16:10:21', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-05-06 16:10:21'),
(21, NULL, 12, 92, '2016-05-06 17:49:11', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-05-06 17:49:11'),
(22, NULL, 10, 92, '2016-06-09 12:20:14', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-09 12:20:14'),
(23, NULL, 13, 92, '2016-06-09 12:20:14', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-09 12:20:14'),
(26, NULL, 179, 92, '2016-06-09 12:45:15', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-09 12:45:15'),
(43, NULL, 208, 92, '2016-10-31 17:00:00', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-10-31 17:00:00'),
(75, NULL, 269, 92, '2017-01-19 13:15:33', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-01-19 13:15:33'),
(627, NULL, 641, 92, '2020-01-19 13:33:54', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-01-19 13:33:54'),
(785, NULL, 699, 92, '2020-05-08 13:08:40', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-05-08 13:08:40'),
(1798, NULL, 816, 92, '2020-06-30 09:11:30', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-06-30 09:11:30'),
(2852, NULL, 866, 92, '2020-08-27 11:21:52', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-08-27 11:21:52'),
(3909, NULL, 871, 92, '2020-09-28 12:55:25', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-09-28 12:55:25'),
(13819, NULL, 2341, 92, '2020-09-09 09:22:05', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-09-09 09:22:05');

-- Bobby Jones Foundation
INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(100, NULL, 1000, 93, '2025-05-15 12:00:00', 0, '[]', '2025-05-15 12:00:00'),
(101, NULL, 1001, 93, '2025-05-15 12:00:00', 0, '[]', '2025-05-15 12:00:00'),
(102, NULL, 1002, 93, '2025-05-15 12:00:00', 0, '[]', '2025-05-15 12:00:00');

-- Demo Test Data
INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(13823, NULL, 979, 93, '2025-04-17 12:00:00', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-04-17 12:00:00'),
(13825, NULL, 2349, 94, '2025-05-14 13:50:00', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-05-14 13:50:00'),
(13826, NULL, 2350, 94, '2025-05-14 13:50:00', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-05-14 13:50:00'),
(13827, NULL, 2351, 94, '2025-05-14 13:50:00', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-05-14 13:50:00'),
(13828, NULL, 979, 94, '2025-05-14 13:50:00', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-05-14 13:50:00'),
(13832, NULL, 979, 96, '2025-04-11 12:16:01', 1, '["mouj1pqpXrYCl994oSm5wtJT3In2", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-04-11 12:16:01'),
(13833, NULL, 960, 96, '2025-05-01 12:28:00', 1, '["dR2Cb1Yf0vQb4ywvMoAXw1SxbY93", "mouj1pqpXrYCl994oSm5wtJT3In2", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-01 12:28:00'),
(13834, NULL, 105, 96, '2025-05-01 12:28:00', 1, '["dR2Cb1Yf0vQb4ywvMoAXw1SxbY93", "mouj1pqpXrYCl994oSm5wtJT3In2", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-01 12:28:00'),
(13835, NULL, 849, 96, '2025-04-11 12:16:01', 1, '["dR2Cb1Yf0vQb4ywvMoAXw1SxbY93", "mouj1pqpXrYCl994oSm5wtJT3In2", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-04-11 12:16:01'),
(13836, NULL, 643, 96, '2025-05-01 12:28:00', 1, '["dR2Cb1Yf0vQb4ywvMoAXw1SxbY93", "mouj1pqpXrYCl994oSm5wtJT3In2", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-01 12:28:00'),
(13842, NULL, 979, 99, '2019-01-10 12:50:00', 1, '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]', '2019-01-10 12:50:00'),
(13843, NULL, 979, 100, '2025-02-15 15:38:00', 0, '[]', '2025-02-15 15:38:00'),
(13844, NULL, 979, 101, '2025-04-25 15:38:07', 1, '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-04-25 15:38:07'),
(13845, NULL, 2370, 99, '2019-02-03 12:50:00', 1, '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]', '2019-02-03 12:50:00'),
(13846, NULL, 2371, 99, '2019-02-03 12:50:00', 1, '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]', '2019-02-03 12:50:00'),
(13847, NULL, 2379, 99, '2019-02-03 12:50:00', 1, '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]', '2019-02-03 12:50:00'),
(13848, NULL, 2370, 101, '2025-04-25 15:38:07', 1, '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-04-25 15:38:07'),
(13849, NULL, 2387, 100, '2025-03-02 13:00:00', 1, '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]', '2025-03-02 13:00:00'),
(13850, NULL, 105, 103, '2025-04-02 13:00:00', 1, '["hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-04-02 13:00:00'),
(13852, NULL, 979, 103, '2025-04-03 10:10:00', 1, '["hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-04-03 10:10:00'),
(13853, NULL, 979, 102, '2025-04-11 12:00:00', 1, '["hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-04-11 12:00:00'),
(13854, NULL, 105, 102, '2025-04-11 12:00:00', 1, '["OPWj4Cj5iRfgva4b3HGtVGjvuk13", "hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-04-11 12:00:00'),
(13855, NULL, 960, 102, '2025-04-11 12:00:00', 1, '["OPWj4Cj5iRfgva4b3HGtVGjvuk13", "hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-04-11 12:00:00'),
(13856, NULL, 849, 102, '2025-04-11 12:00:00', 1, '["OPWj4Cj5iRfgva4b3HGtVGjvuk13", "hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-04-11 12:00:00');
