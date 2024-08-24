codeunit 70003 "Send perf Comm"
{
    Description = 'Envoyez les performances commerciale par mail';
    trigger OnRun()
    var

    begin

        ParametreMarketing.Get();

        EmailReceveur := ParametreMarketing."Email Notification";
        if EmailReceveur = '' then begin
            EmailReceveur := 'ikacou@smartechnologies.com';
        end;
        EmailMessage.Create(EmailReceveur, 'Performance Commerciale', 'Performance commercial du mois');
        AttachmentTempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::PerformanceCommercial, 'Performance Commerciale' + Format(WorkDate()), ReportFormat::Pdf, OutStr, RecRef);
        AttachmentTempBlob.CreateInStream(InStr);
        EmailMessage.AddAttachment('Performance Commerciale' + Format((WorkDate())) + '.pdf', 'PDF', InStr);
        Email.Enqueue(EmailMessage);

    end;

    var
        myInt: Integer;
        EmailItem: Record "Email Item" temporary;
        RecRef: RecordRef;
        OutStr: OutStream;
        InStr: InStream;
        BodyTxt: Text;
        EmailReceveur: Text;
        EmailMessage: Codeunit "Email Message";
        tempBlob: Codeunit "Temp Blob";
        AttachmentInStream: InStream;
        Email: Codeunit Email;
        Recipients: List of [Text];

        emailScenario: Enum "Email Scenario";
        AttachmentTempBlob: Codeunit "Temp Blob";
        ParametreMarketing: Record "Marketing Setup";



}