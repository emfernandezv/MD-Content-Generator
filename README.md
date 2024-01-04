# MD-Content-Generator Overview

MD Content Generator is a sql script that allows to generate MD file content based on a table PMSctructure. The script creates a header and a table based on the data. It also modifies dynamically the content of the description field by search a keyword to get whole words, alter it and replacing it on the text.

The scripts uses as source of truth a table named PMSctructure 

# Development Environment
- SQL

# Future Work
- Add the automatic file generation to the loop to make it create the files on demand.

#To recreate the environment

```sql

create table PMStructure(
tableName varchar(100),
columnName varchar(100),
dataType varchar(100),
description varchar(6000)
);

```
Sample Data for the table:

```sql

insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','LicenseKey','int','License Key / Office Key');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','BatchInformation_UID','int','Unique identifier for the table');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','BatchNumber','int','The batch number viewed on the front end');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','PostingDate','datetime','Timestamp of when the batch was created');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','ServiceDate','datetime','Date set on the batch information screen');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','DateClosed','datetime','Timestamp of when the batch was closed');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','Status','char(1)','A = Active, C = Closed, O = Open');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','BatchOwner','varchar(12)','Name of the user currently using the batch');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','CreatedAt','datetime','Timestamp of when the record was created');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','CreatedBy','char(12)','User who created the record');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','ChangedBy','varchar(12)','User who last updated the record');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','ChangedAt','datetime','Timestamp of when the record was last updated');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','Display','bit','0 = No, 1 = Yes');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','ReceiveDate','datetime','Date set on the batch information screen');
insert into PMStructure VALUES ('vw_ODBC_actv_BatchInformation','DepositDate','datetime','Deposit Date');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','LicenseKey','int','License Key / Office Key');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','CarrierBillingHistory_UID','int','Unique identifier for the table');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','SeqNumberLastBilled','int','Insurance sequence number that was last billed');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','CarrierBilledDate','datetime','Timestamp of when the carrier was billed');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','ChargeDetailFID','int','Foreign key to the vw_ODBC_actv_ChargeDetail table');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','VisitFID','int','Foreign key to the vw_ODBC_appts_Appointments table');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','ProxyVisitFID','int','Foreign key to the vw_ODBC_appts_Appointments table');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','ClaimIDSuffix','char(2)','Two character field used to track the claim billing order.  First claim = ' A', second claim = ' B' etc.');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','ClaimID','varchar(12)','Concatenation of the VisitFID and the ClaimIDSuffix');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','PaperEDI','char(1)','P = Paper, E = Electronic, X = Crossover');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','CarrierFID','int','Foreign key to the vw_ODBC_mf_Carriers table');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','CarrierCode','varchar(8)','Carrier code that was billed');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','PreviousSequenceNumber','int','Previous insurance billing sequence number');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','BilledAmount','money','Amount billed');
insert into PMStructure VALUES ('vw_ODBC_actv_CarrierBillingHistory','IsDemand','bit','0 = No, 1 = Yes');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','LicenseKey','int','License Key / Office Key');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','ChargeDetail_UID','int','Unique identifier for the table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','PostingDate','datetime','Timestamp of when the record was created');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','VisitFID','int','Foreign key to the vw_ODBC_appts_Appointments table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','PatientFID','int','Foreign key to the vw_ODBC_pt_PatientInfo table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','ResponsiblePartyFID','int','Foreign key to the vw_ODBC_pt_ResponsibleParties table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','BeginDateOfService','datetime','Timestamp of when the charge began');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','EndDateOfService','datetime','Timestamp of when the charge ended');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','ChargeCodeFID','int','Foreign key to the vw_ODBC_mf_ProcChargeCodes table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','PlaceOfServiceFID','int','Foreign key to the vw_ODBC_mf_PlaceOfService table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','TypeOfServiceFID','int','Foreign key to the vw_ODBC_mf_TypeOfService table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','AgingDate','datetime','Timestamp updated to the last activity on the record');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','BillInsurance','bit','0 = Insurance should not be billed, 1 = Insurance should be billed');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','InsuranceBilled','bit','0 = Insurance has not been billed, 1 = Insurance has been billed');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','Fee','money','Amount charged');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','Units','decimal(14,1)','Number of units');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','DayClosed','bit','0 = Has not been included on the day close, 1 = included as part of the day close');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','Posted','bit','0 = Has not been posted, 1 = Has been posted');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','Void','bit','0 = Not void, 1 = Void');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','VoidedFID','int','If the record has been voided this contains is a Foreign key to the vw_ODBC__UID column in the same table that has the void offset details');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','LastBilledCarrierSequenceNumber','int','Insurance sequence number that was last billed');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','PaidOff','bit','0 = Not paid off, 1 = Paid off');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','PatientPortion','money','Portion allocated to the patient');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','InsurancePortion','money','Portion allocated to the insurance');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','FinancialClassFID','int','Foreign key to the vw_ODBC_mf_FinancialClasses table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','BatchInformationFID','int','Foreign key to the vw_ODBC_actv_BatchInformation table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','AllowedAmount','money','Allowed amount (from the fee schedule)');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','CreatedBy','char(12)','User who created the record');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','Display','bit','0 = No, 1 = Yes');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','PaymentPlan','bit','0 = Not part of a payment plan, 1 = part of a payment plan');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','InsuranceBalance','money','Remaining amount owed by insurance');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','PatientBalance','money','Remaining amount owed by patient');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','CarrierBillingHistoryFID','int','Foreign key to the vw_ODBC_actv_CarrierBillingHistory Table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','AsstProviderFID','int','Foreign key to the vw_ODBC_mf_PGProfiles table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','ResidentFID','int','Foreign key to the vw_ODBC_mf_PGProfiles table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','Protected','bit','0 = Record is not protected, 1 = Record is protected and cannot be modified');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','NoteFID','int','Foreign key to the vw_ODBC_main_Notes table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','NetFee','bit','0 = Total charged = Fee, 1 = Total charged = Fee * Units');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','LineItemNote','varchar(80)','Line item note');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','IncludeOnStatement','bit','0 = Do not include on statements, 1 = Include on statements');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','Duration','int','Duration of the charge.  Default is 0.');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','COBCodeFID','int','Foreign key to the vw_ODBC_mf_COBCodes table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','CreatedAt','datetime','Timestamp of when the record was created');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','ChangedAt','datetime','Timestamp of when the record was last updated');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','ChangedBy','varchar(12)','User who last updated the record');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','DiagnosisCodes','varchar(255)','Calculated list of all diagnosis codes for the charge');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','Modifiers','varchar(50)','Calculated list of all modifiers for the charge');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','AssessmentDate','datetime','Timestamp of the assessment date');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','AttendingPrvProfileFID','int','Foreign key to the vw_ODBC_mf_PGProfiles table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','NonCoveredCharges','money','Amount of the charge that is not covered');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','OperatingPrvProfileFID','int','Foreign key to the vw_ODBC_mf_PGProfiles table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','OtherProviderProfileFID','int','Foreign key to the vw_ODBC_mf_PGProfiles table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','FacilityTaxAmount','money','Facility tax amount');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','ServiceTaxAmount','money','Service tax amount');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','UnitsTypeCode','varchar(2)','User code that defines the unit type');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','DOSWasSystemGenerated','bit','0 = Date of service was not system generated, 1 = Date of service was system generated');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','TotalDue','money','InsBalance + PatBalance');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','TotalPortion','money','InsurancePortion + PatientPortion');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','BillStatusFID','int','83 = Primary, 84 = Non primary, 85 = Patient');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','FirstTimeUnbilled','datetime','Date the charge first entered unbilled status');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','PeriodFID','int','Foreign key to the vw_ODBC_hc_Period table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','ExpectedAmount','money','Expected amount');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','NDCPrice','money','NDCPrice');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','NDCQuantity','money','NDCQuantity');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','NDCMeasureFID','int','Foreign key to the vw_ODBC_misc_SelectListOption table');
insert into PMStructure VALUES ('vw_ODBC_actv_ChargeDetail','AuthorizationCountFID','int','Foreign key to the pt_AuthorizationCounts');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','LicenseKey','int','License Key / Office Key');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','ClaimEdit_UID','int','Unique identifier for the table');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','VisitFID','int','Foreign key to the vw_ODBC_appts_Appointments table');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','ClaimEditFID','int','Foreign key to the vw_ODBC_mf_ClaimEditStatuses table');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','RuleCode','varchar(14)','Rule Code');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','ProcedureCode','varchar(80)','Procedure code of the line item with the error');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','ErrorMessage','varchar(4096)','Full error message');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','ShortErrorMessage','varchar(50)','Shortened error message');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','ClaimEditStatusFID','int','Foreign key to the vw_ODBC_mf_ClaimEditStatuses table');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','CreatedBy','varchar(12)','User who created the record');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','CreatedAt','datetime','Timestamp of when the record was created');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','ChangedBy','varchar(12)','User who last updated the record');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimEdits','ChangedAt','datetime','Timestamp of when the record was last updated');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','ClaimRun_UID','int','Unique identifier for the table');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','LicenseKey','int','License Key / Office Key');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','SubmitterFID','int','Identifier from edi_Submitters.  Defines the submitter used for this claim run.  This allows us to display the submitter code and derive the Electronic / paper / other information');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','CreatedBy','varchar(12)','User who created the record');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','CreatedAt','datetime','Timestamp of when the record was created');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','ChangedBy','varchar(12)','User who last updated the record');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','ChangedAt','datetime','Timestamp of when the record was last updated');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','TotalAmount','money','Total dollar amount of claim run');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','SubmittedAt','datetime','Defines the date and time where the claim run / file was submitted to a third party clearing house.  This may also be used to determine when a paper claim run was printed or an 837 file was downloaded.  This value is NULL until a submission tracking event is logged by the claim tracking system');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','ReceivedAt','datetime','Defines the date and time where the third party clearing house received the claim run.  This value is NULL until a receipt acknowledgement tracking event is logged by the claim tracking system.');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','PaidAt','datetime','Defines the date and time where the claim is considered paid and the lifecycle is complete.  This value should typically be set by a payment being made against the visit / claim included in the claim run.  We may also include the ability for a user to manually mark a claim run as paid for the paper claim / electronic download situations.');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','ClaimTemplateFID','int','Optional claim template document used for paper claim processing');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','DataFileURL','varchar(255)','relative (relative to ClaimURL registry setting) URL to claim data file, example: 837/847003.050207.31.837');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','HTMLFileURL','varchar(255)','relative (relative to ClaimURL registry setting) URL to claim report file, example: 837/847003.050207.31.html');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','FilePath','varchar(255)','Defines the file name and possible relative path of the claim run.  This value also needs to exist at the enterprise level for the claim tracking to resolve an office key given a file name.');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','TrackingNumber','char(9)','ANSI X12 tracking number created by AdvancedMD when an EDI file is generated.  Used to match EDI transmissions back to a specific claim run.  I believe this maps to the ISA13__InterchangeControlNumber field.  This value also needs to exist at the enterprise level for the claim tracking to resolve an office key given a tracking number.');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','TestMode','bit','Was this claim run executed in test mode?  In other words, at the time of the claim run generation, was the Test flag set for the submitter type?');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','ClaimCount','int','Number of claims in the run');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','IsDemand','bit','0 = No, 1 = Yes');
insert into PMStructure VALUES ('vw_ODBC_actv_ClaimRun','IsTrial','bit','0 = No, 1 = Yes');

```

The script will display an output for each "table" registered, from there you can "copy & paste" or apply 

```sql

DECLARE @strbcpcmd NVARCHAR(max)
SET @strbcpcmd = 'bcp  "SELECT * FROM #template" queryout "C:\test.MD" -w -C OEM -t"$" -T -S'+@@servername    
EXEC master..xp_cmdshell @strbcpcmd

```

to generate automatically the MD file on a local folder

Output Example:

![image](https://github.com/emfernandezv/MD-Content-Generator/assets/36644789/315d0153-c831-4c58-9225-5ee2a0a86e5d)



