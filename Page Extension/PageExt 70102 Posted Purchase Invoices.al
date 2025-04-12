pageextension 70102 "Posted Purchase Invoices" extends "Posted Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Invoice")
        {
            action("Create Payment")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payer le ticket';
                Promoted = true;
                PromotedCategory = Process;
                Image = SuggestVendorPayments;
                ToolTip = 'Create a payment journal based on the selected invoices.';

                trigger OnAction()
                var

                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                    GenJournalBatch: Record "Gen. Journal Batch";
                    GenJnlManagement: Codeunit GenJnlManagement;
                    CreatePayment: Page "Create Payment";
                    PurchInvHeader: Record "Purch. Inv. Header";
                    GenJournalLine: Record "Gen. Journal Line";
                begin
                    // CurrPage.SetSelectionFilter(VendorLedgerEntry);
                    VendorLedgerEntry.SetRange("Document No.", rec."No.");
                    if VendorLedgerEntry.FindFirst() then begin
                        if CreatePayment.RunModal() = ACTION::OK then begin
                            CreatePayment.MakeGenJnlLines(VendorLedgerEntry);
                            GetBatchRecord(GenJournalBatch, CreatePayment);
                            GenJnlManagement.TemplateSelectionFromBatch(GenJournalBatch);
                            //<<Fab
                            // Message('a: %1 b: %2', GenJournalBatch."Journal Template Name", GenJournalBatch.Name);
                            GenJournalLine.SetRange("Journal Template Name", GenJournalBatch."Journal Template Name");
                            GenJournalLine.SetRange("Journal Batch Name", GenJournalBatch.Name);
                            if GenJournalLine.FindFirst() then begin
                                GenJournalLine.SendToPosting(Codeunit::"Gen. Jnl.-Post");
                            end;
                            // 
                            //<<Fab
                            Clear(CreatePayment);
                        end else
                            Clear(CreatePayment);

                    end;

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