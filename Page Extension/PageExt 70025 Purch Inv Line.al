pageextension 70025 "Posted Purch. Invoice SubformX" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Lot Qty"; rec."Lot Qty")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("&Line")
        {
            action(Annuler)
            {
                ApplicationArea = All;
                Caption = 'Annuler2';
                Promoted = true;
                PromotedCategory = Category10;
                trigger OnAction()
                var
                    // silue samuel 07/03/2025 SalesInvoiceLine: Record "Sales Invoice Line";
                begin
                    UndoReceiptLine();
                    // Codeunit.Run(Codeunit::"Undo Purchase Receipt Line", SalesInvoiceLine)
                end;

            }
        }
    }
    local procedure UndoReceiptLine()
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.Copy(Rec);
        CurrPage.SetSelectionFilter(PurchRcptLine);
        CODEUNIT.Run(CODEUNIT::"Undo Purchase Receipt Line", PurchRcptLine);
    end;

    var
        myInt: Integer;
        PAG: Page 54;
}