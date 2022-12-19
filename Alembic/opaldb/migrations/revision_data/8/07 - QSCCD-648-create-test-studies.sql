-- This script inserts test study records only if executed in a Development environment.
-- Please see OpalDB.BuildType table

SET @environment := (SELECT `Name` FROM `BuildType`);

INSERT INTO `study` (`ID`, `consentQuestionnaireId`, `code`, `title_EN`, `title_FR`, `description_EN`, `description_FR`, `investigator`, `email`, `phone`, `phoneExt`, `startDate`, `endDate`, `deleted`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`)
(
    SELECT *
    FROM (
        SELECT 1 AS `ID`, 182 AS `consentQuestionnaireId`, 'jwatson-head-neck-2022-03-15' AS `code`, 'Predicting head and neck cancer radiotherapy replanning based on anatomical changes in the patient' AS `title_EN`, 'Prédire la replanification de la radiothérapie des cancers de la tête et du cou en fonction des modifications anatomiques du patient' AS `title_FR`, '<p>Head and neck cancer (HNC) patients who undergo radiotherapy often experience several treatment-related toxicities (Trotti 2000). Early effects of radiation in the head and neck region include xerostomia, dysphagia, mucositis and dermatits (Trotti 2000; Muzumder et al. 2019), which negatively impact patients'' nutrotional status and cause weight loss (Larsson et al. 2003).<br/></p>' AS `description_EN`, '<p>Les patients atteints d''un cancer de la tête et du cou (HNC) qui subissent une radiothérapie éprouvent souvent plusieurs toxicités liées au traitement (Trotti 2000). Les premiers effets de la radiothérapie dans la région de la tête et du cou comprennent la xérostomie, la dysphagie, la mucosite et les dermatites (Trotti 2000; Muzumder et al. 2019), qui ont un impact négatif sur l''état nutritionnel des patients et entraînent une perte de poids (Larsson et al. 2003).<br/></p>' AS `description_FR`, 'John Watson' AS `investigator`, 'john.watson@mcgill.ca'  AS `email`, '5145145145' AS `phone`, NULL AS `phoneExt`, '2022-03-15' AS `startDate`, '2023-06-01' AS `endDate`, 0 AS `deleted`, '2022-03-15 13:41:25' AS `creationDate`, 'MOYI6000' AS `createdBy`, NOW() AS `lastUpdated`, 'MOYI6000' AS `updatedBy`
        UNION
        SELECT 2 AS `ID`, 224 AS `consentQuestionnaireId`, 'jkildea-radiotherapy-2022-04-01' AS `code`, 'Radiotherapy on blood cell count' AS `title_EN`, 'Radiothérapie sur la numération globulaire' AS `title_FR`, '<p>This study aims to determine the effects of radiotherapy on blood cell count. In particular, radiotherapy affects the immune system, which is controlled in part by white blood cells (lymphocytes). In this study, we will analyze how different subsets of white blood cells fluctuate over the course of radiotherapy treatment.<br/></p>' AS `description_EN`, '<p>Cette étude vise à déterminer les effets de la radiothérapie sur la numération globulaire. En particulier, la radiothérapie affecte le système immunitaire, qui est contrôlé en partie par les globules blancs (lymphocytes). Dans cette étude, nous analyserons comment différents sous-ensembles de globules blancs fluctuent au cours du traitement de radiothérapie.<br/></p>' AS `description_FR`, 'John Kildea' AS `investigator`, 'john.kildea@mcgill.ca' AS `email`, '5145145145' AS `phone`, NULL AS `phoneExt`, '2022-04-01' AS `startDate`, '2023-07-01' AS `endDate`, 0 AS `deleted`, '2022-04-01 15:30:30' AS `creationDate`, 'admin' AS `createdBy`, NOW() AS `lastUpdated`, 'admin' AS `updatedBy`
        UNION
        SELECT 3 AS `ID`, 167 AS `consentQuestionnaireId`, 'noname-COVID19-2021-03-17' AS `code`, 'COVID-19 Study' AS `title_EN`, 'Étude COVID-19' AS `title_FR`, '<p>Coronavirus disease 2019 (COVID-19) is a contagious disease caused by a virus, the severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2). The first known case was identified in Wuhan, China, in December 2019.<br/></p>' AS `description_EN`, '<p>La maladie à coronavirus 2019 (COVID-19) est une maladie contagieuse causée par un virus, le coronavirus 2 du syndrome respiratoire aigu sévère (SARS-CoV-2). Le premier cas connu a été identifié à Wuhan, en Chine, en décembre 2019.<br/></p>' AS `description_FR`, 'No Name' AS `investigator`, NULL  AS `email`, NULL AS `phone`, NULL AS `phoneExt`, '2021-03-17' AS `startDate`, '2022-10-24' AS `endDate`, 0 AS `deleted`, '2021-03-17 08:59:50' AS `creationDate`, 'CABR6008' AS `createdBy`, NOW() AS `lastUpdated`, 'CABR6008' AS `updatedBy`
        UNION
        SELECT 4 AS `ID`, 217 AS `consentQuestionnaireId`, 'lisa-breast-cancer-2021-04-20' AS `code`, 'Breast Cancer Treatment Study' AS `title_EN`, 'Étude sur le traitement du cancer du sein' AS `title_FR`, '<p>This study aims to determine the effects of radiotherapy on blood cell count. In particular, radiotherapy affects the immune system, which is controlled in part by white blood cells (lymphocytes). In this study, we will analyze how different subsets of white blood cells fluctuate over the course of radiotherapy treatment.<br/></p>' AS `description_EN`, '<p>Cette étude vise à déterminer les effets de la radiothérapie sur la numération globulaire. En particulier, la radiothérapie affecte le système immunitaire, qui est contrôlé en partie par les globules blancs (lymphocytes). Dans cette étude, nous analyserons comment différents sous-ensembles de globules blancs fluctuent au cours du traitement de radiothérapie.<br/></p>' AS `description_FR`, 'Lisa Simpson' AS `investigator`, 'lisa.simpson@mcgill.ca' AS `email`, '5145145145' AS `phone`, NULL AS `phoneExt`, '2022-05-13' AS `startDate`, '2023-06-30' AS `endDate`, 0 AS `deleted`, '2022-04-20 19:50:07' AS `creationDate`, 'FAMA6017' AS `createdBy`, NOW() AS `lastUpdated`, 'FAMA6017' AS `updatedBy`
        UNION
        SELECT 5 AS `ID`, 113 AS `consentQuestionnaireId`, 'bart-DNA-mutations-2021-12-12' AS `code`, 'An investigation into DNA mutations during radiotherapy' AS `title_EN`, 'Une enquête sur les mutations de l''ADN au cours de la radiothérapie' AS `title_FR`, '<p>A mutation is a change in the DNA sequence of an organism. Mutations can result from errors in DNA replication during cell division, exposure to mutagens or a viral infection.<br/></p>' AS `description_EN`, '<p>Une mutation est un changement dans la séquence d''ADN d''un organisme. Les mutations peuvent résulter d''erreurs de réplication de l''ADN lors de la division cellulaire, d''une exposition à des mutagènes ou d''une infection virale.<br/></p>' AS `description_FR`, 'Bart Simpson' AS `investigator`, 'bart.simpson@mcgill.ca' AS `email`, '5145145145' AS `phone`, NULL AS `phoneExt`, '2022-01-01' AS `startDate`, '2023-09-01' AS `endDate`, 0 AS `deleted`, '2021-12-12 9:30:35' AS `creationDate`, 'admin' AS `createdBy`, NOW() AS `lastUpdated`, 'admin' AS `updatedBy`
        UNION
        SELECT 6 AS `ID`, 221 AS `consentQuestionnaireId`, 'jdoe-bone-metastasis-2020-03-01' AS `code`, 'Predicting pain in patients with bone metastasis using radiomics and patient-reported outcomes study' AS `title_EN`, 'Prédire la douleur chez les patients présentant des métastases osseuses à l''aide de la radiomique et de l''étude des résultats rapportés par les patients' AS `title_FR`, '<p>Bone metastasis occurs when cancer cells spread from their original site to a bone. Nearly all types of cancer can spread (metastasize) to the bones. But some types of cancer are particularly likely to spread to bone, including breast cancer and prostate cancer.<br/></p>' AS `description_EN`, '<p>La métastase osseuse se produit lorsque les cellules cancéreuses se propagent de leur site d''origine à un os. Presque tous les types de cancer peuvent se propager (métastaser) aux os. Mais certains types de cancer sont particulièrement susceptibles de se propager aux os, notamment le cancer du sein et le cancer de la prostate.<br/></p>' AS `description_FR`, 'Jane Doe' AS `investigator`, 'jane.doe@mcgill.ca' AS `email`, '5145145145' AS `phone`, '1' AS `phoneExt`, '2020-03-01' AS `startDate`, '2022-03-01' AS `endDate`, 0 AS `deleted`, '2020-01-12 19:28:07' AS `creationDate`, 'admin' AS `createdBy`, NOW() AS `lastUpdated`, 'admin' AS `updatedBy`
        UNION
        SELECT 7 AS `ID`, 222 AS `consentQuestionnaireId`, 'jkildea-prostate-gas-2019-12-01' AS `code`, 'Prostate cancer gas-reducing diet to improve radiotherapy study' AS `title_EN`, 'Régime de réduction des gaz du cancer de la prostate pour améliorer l''étude de la radiothérapie' AS `title_FR`, '<p>Prostate cancer is cancer of the prostate. Prostate cancer is the second most common cancerous tumor worldwide and is the fifth leading cause of cancer-related mortality among men.<br/></p>' AS `description_EN`, '<p>Le cancer de la prostate est un cancer de la prostate. Le cancer de la prostate est la deuxième tumeur cancéreuse la plus répandue dans le monde et la cinquième cause de mortalité liée au cancer chez les hommes.<br/></p>' AS `description_FR`, 'John Kildea' AS `investigator`, 'john.kildea@mcgill.ca' AS `email`, '5145145145' AS `phone`, NULL  AS `phoneExt`, '2019-12-01' AS `startDate`, '2023-12-01' AS `endDate`, 0 AS `deleted`, '2019-05-01 13:35:17' AS `creationDate`, 'admin' AS `createdBy`, NOW() AS `lastUpdated`, 'admin' AS `updatedBy`
    ) TMP_TBL
    WHERE @environment = 'Development'
);

INSERT INTO `questionnaireStudy` (`ID`, `studyId`, `questionnaireId`)
(
    SELECT *
    FROM (
        SELECT 1 AS `ID`, 1 AS `studyId`, 150 AS `questionnaireId`
        UNION
        SELECT 2 AS `ID`, 2 AS `studyId`, 164 AS `questionnaireId`
        UNION
        SELECT 3 AS `ID`, 3 AS `studyId`, 242 AS `questionnaireId`
        UNION
        SELECT 4 AS `ID`, 4 AS `studyId`, 170 AS `questionnaireId`
        UNION
        SELECT 5 AS `ID`, 5 AS `studyId`, 188 AS `questionnaireId`
        UNION
        SELECT 6 AS `ID`, 6 AS `studyId`, 158 AS `questionnaireId`
        UNION
        SELECT 7 AS `ID`, 7 AS `studyId`, 163 AS `questionnaireId`
    ) TMP_TBL
    WHERE @environment = 'Development'
);

INSERT INTO `patientStudy` (`ID`, `patientId`, `studyId`, `consentStatus`, `readStatus`)
(
    SELECT *
    FROM (
        SELECT 1 AS `ID`, 51 AS `patientId`, 1 AS `studyId`, 1 AS `consentStatus`, 0 AS `readStatus`
        UNION
        SELECT 2 AS `ID`, 51 AS `patientId`, 2 AS `studyId`, 1 AS `consentStatus`, 1 AS `readStatus`
        UNION
        SELECT 3 AS `ID`, 51 AS `patientId`, 3 AS `studyId`, 2 AS `consentStatus`, 1 AS `readStatus`
        UNION
        SELECT 4 AS `ID`, 51 AS `patientId`, 4 AS `studyId`, 3 AS `consentStatus`, 1 AS `readStatus`
        UNION
        SELECT 5 AS `ID`, 51 AS `patientId`, 5 AS `studyId`, 4 AS `consentStatus`, 1 AS `readStatus`
        UNION
        SELECT 6 AS `ID`, 51 AS `patientId`, 6 AS `studyId`, 1 AS `consentStatus`, 0 AS `readStatus`
        UNION
        SELECT 7 AS `ID`, 51 AS `patientId`, 7 AS `studyId`, 1 AS `consentStatus`, 0 AS `readStatus`
    ) TMP_TBL
    WHERE @environment = 'Development'
);
