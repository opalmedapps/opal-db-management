QSCCD-641: creates new "EducationalMaterialCategory" table used in the "Research Menu" module.
It will allow different categories of educational materials to be re-used/co-exist in the infrastructure.

The script creates two different categories of the educational materials:
 - "clinical" (belonging in the original education page);
 - "research" (belonging in the reference material page of the "Research Menu").

Sets all the existing education materials under "clinical" category.

=============================================================================================

QSCCD-642: adds new "lastUpdated" field to the "patientStudy" table that allows to see 
when the consent was updated.

Creates "patientStudyMH" table along with "patientStudy_after_insert", "patientStudy_after_update", and
"patientStudy_after_delete" triggers for auditing purposes.

Sets "lastUpdated" for all the existing "patientStudy" records.

=============================================================================================

QSCCD-648: creates test "reference materials" (a.k.a., "educational materials") and "studies" records for the "Research Menu" module.
It allows us to test "qplus/listener" without creating new "studies"/"reference materials"
in the legacy "opalAdmin".

Creates test studies and `links` them to the test patients through the "patientStudy" table.

=============================================================================================
