pageextension 70102 "Posted Purchase Invoices" extends "Posted Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
    }
    
    actions
    {
        addafter("&Invoice"){
             action("Create Payment")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payer le ticket';
                Image = SuggestVendorPayments;
                ToolTip = 'Create a payment journal based on the selected invoices.';

                trigger OnAction()
                var
                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                    GenJournalBatch: Record "Gen. Journal Batch";
                    GenJnlManagement: Codeunit GenJnlManagement;
                    CreatePayment: Page "Create Payment";
                begin
                    CurrPage.SetSelectionFilter(VendorLedgerEntry);
                    if CreatePayment.RunModal() = ACTION::OK then begin
                        CreatePayment.MakeGenJnlLines(VendorLedgerEntry);
                        GetBatchRecord(GenJournalBatch, CreatePayment);
                        GenJnlManagement.TemplateSelectionFromBatch(GenJournalBatch);
                        Clear(CreatePayment);
                    end else
                        Clear(CreatePayment);
                end;
            }
        }
    }
    local procedure GetBatchRecord(var GenJournalBatch: Record "Gen. Journal Batch"; CreatePayment: Page "Create Payment")
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
    begin
        JournalTemplateName := CreatePayment.GetTemplateName();
        JournalBatchName := CreatePayment.GetBatchNumber();

        GenJournalTemplate.Get(JournalTemplateName);
        GenJournalBatch.Get(JournalTemplateName, JournalBatchName);
    end;

    var
        myInt: Integer;
}