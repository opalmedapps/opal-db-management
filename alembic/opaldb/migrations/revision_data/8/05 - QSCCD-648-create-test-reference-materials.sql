-- This script inserts test reference (a.k.a. educational) materials
-- only if executed in a Development environment.
-- Please see OpalDB.BuildType table

SET @environment := (SELECT `Name` FROM `BuildType`);

SET @controlMaxSer := (SELECT MAX(`EducationalMaterialControlSerNum`) FROM `EducationalMaterialControl`);

SET @researchCategory := (SELECT `ID` FROM `EducationalMaterialCategory` WHERE `title_EN` = "Research" AND `title_FR` = "Recherche");

INSERT INTO `EducationalMaterialControl` (`EducationalMaterialControlSerNum`, `EducationalMaterialType_EN`, `EducationalMaterialType_FR`, `EducationalMaterialCategoryId`, `Name_EN`, `Name_FR`, `URL_EN`, `URL_FR`, `URLType_EN`, `URLType_FR`, `ShareURL_EN`, `ShareURL_FR`, `PhaseInTreatmentSerNum`, `ParentFlag`, `deleted`)
(
    SELECT *
    FROM (
        SELECT @controlMaxSer := @controlMaxSer+1 AS `EducationalMaterialControlSerNum`, "Booklet" AS `EducationalMaterialType_EN`, "Brochure" AS `EducationalMaterialType_FR`, @researchCategory AS `EducationalMaterialCategoryId`, 'What is Radiotherapy?' AS `Name_EN`, "Qu'est-ce que la radiothérapie?" AS `Name_FR`, "https://www.depdocs.com/opal/educational/pathway/EN_Radiotherapy/what_is_radiotherapy.php" AS `URL_EN`, "https://www.depdocs.com/opal/educational/pathway/EN_Radiotherapy/what_is_radiotherapy.php" AS `URL_FR`, "website" AS `URLType_EN`, "website" AS `URLType_FR`, NULL AS `ShareURL_EN`, NULL AS `ShareURL_FR`, 1 AS `PhaseInTreatmentSerNum`, 1 AS `ParentFlag`, 0 AS `deleted`
        UNION
        SELECT @controlMaxSer := @controlMaxSer+1 AS `EducationalMaterialControlSerNum`, "Factsheet" AS `EducationalMaterialType_EN`, "Fiche descriptive" AS `EducationalMaterialType_FR`, @researchCategory AS `EducationalMaterialCategoryId`, "Acknowledgment of Sources" AS `Name_EN`, "Reconnaissance des sources" AS `Name_FR`, "https://www.depdocs.com/opal/educational/MGH-IBD/WordDoc/7_Acknowledgments.php" AS `URL_EN`, "https://www.depdocs.com/opal/educational/MGH-IBD/WordDoc/7_R%C3%A9f%C3%A9rences.php" AS `URL_FR`, "website" AS `URLType_EN`, "website" AS `URLType_FR`, NULL AS `ShareURL_EN`, NULL AS `ShareURL_FR`, 1 AS `PhaseInTreatmentSerNum`, 1 AS `ParentFlag`, 0 AS `deleted`
        UNION
        SELECT @controlMaxSer := @controlMaxSer+1 AS `EducationalMaterialControlSerNum`, "Factsheet" AS `EducationalMaterialType_EN`, "Fiche descriptive" AS `EducationalMaterialType_FR`, @researchCategory AS `EducationalMaterialCategoryId`, "Flexible Sigmoidoscopy" AS `Name_EN`, "Sigmoidoscopie flexible" AS `Name_FR`, "https://www.depdocs.com/opal/educational/MGH-IBD/Flexible_Sigmoidoscopy.pdf" AS `URL_EN`, "https://www.depdocs.com/opal/educational/MGH-IBD/Sigmoidoscopie_Flexible_FR.pdf" AS `URL_FR`, "pdf" AS `URLType_EN`, "pdf" AS `URLType_FR`, "https://www.depdocs.com/opal/educational/MGH-IBD/Flexible_Sigmoidoscopy.pdf" AS `ShareURL_EN`, "https://www.depdocs.com/opal/educational/MGH-IBD/Sigmoidoscopie_Flexible_FR.pdf" AS `ShareURL_FR`, 1 AS `PhaseInTreatmentSerNum`, 1 AS `ParentFlag`, 0 AS `deleted`
        UNION
        SELECT @controlMaxSer := @controlMaxSer+1 AS `EducationalMaterialControlSerNum`, "Test Results" AS `EducationalMaterialType_EN`, "Résultats de Test de laboratoire" AS `EducationalMaterialType_FR`, @researchCategory AS `EducationalMaterialCategoryId`, "Immunophenotyping by Flow Cytometry" AS `Name_EN`, "Immunophénotypage" AS `Name_FR`, "https://labtestsonline.org/tests/immunophenotyping-flow-cytometry" AS `URL_EN`, "http://www.labtestsonline.fr/tests/immunoph-notypage.html?tab=1" AS `URL_FR`, "website" AS `URLType_EN`, "website" AS `URLType_FR`, NULL AS `ShareURL_EN`, NULL AS `ShareURL_FR`, 1 AS `PhaseInTreatmentSerNum`, 1 AS `ParentFlag`, 0 AS `deleted`
        UNION
        SELECT @controlMaxSer := @controlMaxSer+1 AS `EducationalMaterialControlSerNum`, "Treatment Guidelines" AS `EducationalMaterialType_EN`, "Directives de traitement" AS `EducationalMaterialType_FR`, @researchCategory AS `EducationalMaterialCategoryId`, "Breast Cancer PDF" AS `Name_EN`, "Cancer du Sein PDF" AS `Name_FR`, "https://www.depdocs.com/opal/educational/pathway/breast/EN/breast-radiotherapy-treatment-guidelines.pdf" AS `URL_EN`, "https://www.depdocs.com/opal/educational/pathway/breast/EN/breast-radiotherapy-treatment-guidelines.pdf" AS `URL_FR`, "pdf" AS `URLType_EN`, "pdf" AS `URLType_FR`, NULL AS `ShareURL_EN`, NULL AS `ShareURL_FR`, 1 AS `PhaseInTreatmentSerNum`, 1 AS `ParentFlag`, 0 AS `deleted`
        UNION
        SELECT @controlMaxSer := @controlMaxSer+1 AS `EducationalMaterialControlSerNum`, "Video" AS `EducationalMaterialType_EN`, "Vidéo" AS `EducationalMaterialType_FR`, @researchCategory AS `EducationalMaterialCategoryId`, "Planning for your radiotherapy" AS `Name_EN`, "La planification de votre radiothérapie" AS `Name_FR`, "https://www.youtube.com/embed/c8nHbGPs5SE" AS `URL_EN`, "https://www.youtube.com/embed/2dPfuxb1H8E" AS `URL_FR`, "website" AS `URLType_EN`, "website" AS `URLType_FR`, "https://www.youtube.com/embed/c8nHbGPs5SE" AS `ShareURL_EN`, "https://www.youtube.com/embed/2dPfuxb1H8E" AS `ShareURL_FR`, 1 AS `PhaseInTreatmentSerNum`, 1 AS `ParentFlag`, 0 AS `deleted`
        UNION
        SELECT @controlMaxSer := @controlMaxSer+1 AS `EducationalMaterialControlSerNum`, "Treatment Guidelines" AS `EducationalMaterialType_EN`, "Directives de traitement" AS `EducationalMaterialType_FR`, @researchCategory AS `EducationalMaterialCategoryId`, "Protocol: Sorafenib" AS `Name_EN`, "Protocole: Sorafenib" AS `Name_FR`, "http://www.geoq.info/pro/documents/conseils/1514.pdf" AS `URL_EN`, "http://www.geoq.info/pro/documents/conseils/1012.pdf" AS `URL_FR`, "pdf" AS `URLType_EN`, "pdf" AS `URLType_FR`, "http://www.geoq.info/pro/documents/conseils/1514.pdf" AS `ShareURL_EN`, "http://www.geoq.info/pro/documents/conseils/1012.pdf" AS `ShareURL_FR`, 1 AS `PhaseInTreatmentSerNum`, 1 AS `ParentFlag`, 1 AS `deleted`
        UNION
        SELECT @controlMaxSer := @controlMaxSer+1 AS `EducationalMaterialControlSerNum`, "Video" AS `EducationalMaterialType_EN`, "Vidéo" AS `EducationalMaterialType_FR`, @researchCategory AS `EducationalMaterialCategoryId`, "Immunotherapy" AS `Name_EN`, "Immunothérapie" AS `Name_FR`, "https://precare.ca/immunotherapy/" AS `URL_EN`, "https://precare.ca/immunotherapy/" AS `URL_FR`, "website" AS `URLType_EN`, "website" AS `URLType_FR`, NULL AS `ShareURL_EN`, NULL AS `ShareURL_FR`, 1 AS `PhaseInTreatmentSerNum`, 1 AS `ParentFlag`, 1 AS `deleted`
        UNION
        SELECT @controlMaxSer := @controlMaxSer+1 AS `EducationalMaterialControlSerNum`, "Booklet" AS `EducationalMaterialType_EN`, "Brochure" AS `EducationalMaterialType_FR`, @researchCategory AS `EducationalMaterialCategoryId`, "Patient Guidebook for Patients Facing Radical Cystectomy" AS `Name_EN`, "Guide pour les patients devant subir une cystectomie totale" AS `Name_FR`, "https://www.depdocs.com/opal/educational/Urology/Bladder_Cancer_Muscle-Invasive/Radical_Cystectomy/BCC-Patient-Guidebook-Radical-Cystectomy-EN-Feb2019(3).pdf" AS `URL_EN`, "https://www.depdocs.com/opal/educational/Urology/Bladder_Cancer_Muscle-Invasive/Radical_Cystectomy/BCC-Patient-Guidebook-Radical-Cystectomy-FR-Mar2018(3).pdf" AS `URL_FR`, "pdf" AS `URLType_EN`, "pdf" AS `URLType_FR`, "https://www.depdocs.com/opal/educational/Urology/Bladder_Cancer_Muscle-Invasive/Radical_Cystectomy/BCC-Patient-Guidebook-Radical-Cystectomy-EN-Feb2019(3).pdf" AS `ShareURL_EN`, "https://www.depdocs.com/opal/educational/Urology/Bladder_Cancer_Muscle-Invasive/Radical_Cystectomy/BCC-Patient-Guidebook-Radical-Cystectomy-FR-Mar2018(3).pdf" AS `ShareURL_FR`, 1 AS `PhaseInTreatmentSerNum`, 1 AS `ParentFlag`, 1 AS `deleted`
        UNION
        SELECT @controlMaxSer := @controlMaxSer+1 AS `EducationalMaterialControlSerNum`, "Test Results" AS `EducationalMaterialType_EN`, "Résultats de Test de laboratoire" AS `EducationalMaterialType_FR`, @researchCategory AS `EducationalMaterialCategoryId`, "Cyclic Citrullinated Peptide Antibody" AS `Name_EN`, "Anti-peptides cycliques citrullinés" AS `Name_FR`, "https://labtestsonline.org/tests/cyclic-citrullinated-peptide-antibody" AS `URL_EN`, "http://www.labtestsonline.fr/tests/RheumatoidFactor.html?tab=3" AS `URL_FR`, "website" AS `URLType_EN`, "website" AS `URLType_FR`, NULL AS `ShareURL_EN`, NULL AS `ShareURL_FR`, 1 AS `PhaseInTreatmentSerNum`, 1 AS `ParentFlag`, 1 AS `deleted`
    ) TMP_TBL
    WHERE @environment = 'Development'
);

SET @eduMaxSer := (SELECT MAX(`EducationalMaterialSerNum`) FROM `EducationalMaterial`);

INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`)
(
    SELECT *
    FROM (
        SELECT @eduMaxSer := @eduMaxSer+1 AS `EducationalMaterialSerNum`, @controlMaxSer := @controlMaxSer AS `EducationalMaterialControlSerNum`, 51 AS `PatientSerNum`, NOW() AS `DateAdded`, 0 AS `ReadStatus`
        UNION
        SELECT @eduMaxSer := @eduMaxSer+1 AS `EducationalMaterialSerNum`, @controlMaxSer := @controlMaxSer-1 AS `EducationalMaterialControlSerNum`, 51 AS `PatientSerNum`, NOW() AS `DateAdded`, 0 AS `ReadStatus`
        UNION
        SELECT @eduMaxSer := @eduMaxSer+1 AS `EducationalMaterialSerNum`, @controlMaxSer := @controlMaxSer-1 AS `EducationalMaterialControlSerNum`, 51 AS `PatientSerNum`, NOW() AS `DateAdded`, 0 AS `ReadStatus`
        UNION
        SELECT @eduMaxSer := @eduMaxSer+1 AS `EducationalMaterialSerNum`, @controlMaxSer := @controlMaxSer-1 AS `EducationalMaterialControlSerNum`, 51 AS `PatientSerNum`, NOW() AS `DateAdded`, 0 AS `ReadStatus`
        UNION
        SELECT @eduMaxSer := @eduMaxSer+1 AS `EducationalMaterialSerNum`, @controlMaxSer := @controlMaxSer-1 AS `EducationalMaterialControlSerNum`, 51 AS `PatientSerNum`, NOW() AS `DateAdded`, 0 AS `ReadStatus`
        UNION
        SELECT @eduMaxSer := @eduMaxSer+1 AS `EducationalMaterialSerNum`, @controlMaxSer := @controlMaxSer-1 AS `EducationalMaterialControlSerNum`, 51 AS `PatientSerNum`, NOW() AS `DateAdded`, 1 AS `ReadStatus`
        UNION
        SELECT @eduMaxSer := @eduMaxSer+1 AS `EducationalMaterialSerNum`, @controlMaxSer := @controlMaxSer-1 AS `EducationalMaterialControlSerNum`, 51 AS `PatientSerNum`, NOW() AS `DateAdded`, 1 AS `ReadStatus`
        UNION
        SELECT @eduMaxSer := @eduMaxSer+1 AS `EducationalMaterialSerNum`, @controlMaxSer := @controlMaxSer-1 AS `EducationalMaterialControlSerNum`, 51 AS `PatientSerNum`, NOW() AS `DateAdded`, 1 AS `ReadStatus`
        UNION
        SELECT @eduMaxSer := @eduMaxSer+1 AS `EducationalMaterialSerNum`, @controlMaxSer := @controlMaxSer-1 AS `EducationalMaterialControlSerNum`, 51 AS `PatientSerNum`, NOW() AS `DateAdded`, 1 AS `ReadStatus`
        UNION
        SELECT @eduMaxSer := @eduMaxSer+1 AS `EducationalMaterialSerNum`, @controlMaxSer := @controlMaxSer-1 AS `EducationalMaterialControlSerNum`, 51 AS `PatientSerNum`, NOW() AS `DateAdded`, 1 AS `ReadStatus`
    ) TMP_TBL
    WHERE @environment = 'Development'
);
