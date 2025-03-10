pageextension 70030 "Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(CreateCreditMemo)
        {
            trigger OnBeforeAction()
            var
                PurchInvLine: Record "Purch. Inv. Line";//<<Ligne facture achat enregistré
                // PurchaseLine: Record "Purchase Line";//<<Ligne avoir acaht
                PurchaseHeader: Record "Purchase Header";//<<Entete Avoir achat
                PurchRcptLine: Record "Purch. Rcpt. Line";//<<Ligne réception achat enregistrée

            begin

                // PurchInvLine.SetRange("Document No.", rec."No.");
                // if PurchInvLine.FindSet() then begin
                //     repeat begin
                //         PurchaseLine.SetRange("Order No.", PurchInvLine."Order No.");
                //         PurchaseLine.SetRange("No.", PurchInvLine."No.");
                //         if PurchaseLine.FindFirst() then begin
                //             PurchaseLine."Lot Qty" := PurchInvLine."Lot Qty";
                //             PurchaseLine.Modify();
                //             Message('a:%1 b:%2', PurchaseLine."No.", PurchaseLine."Lot Qty");
                //         end;
                //     end until PurchInvLine.Next() = 0
                // end;
                // PurchaseLine.SetRange("Order No.",);
                // PurchaseHeader.SetRange("Applies-to Doc. No.", rec."No.");
                // if PurchaseHeader.FindFirst() then begin
                //     PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                //     if PurchaseLine.FindSet() then begin
                //         repeat begin
                //             PurchRcptLine.SetRange("Item Rcpt. Entry No.", PurchaseLine."Appl.-to Item Entry");
                //             if PurchRcptLine.FindFirst() then begin
                //                 PurchaseLine."Lot Qty" := PurchRcptLine."Lot Qty";
                //                 PurchaseLine.Modify();
                //                 Message('a1:%1 b1:%2', PurchaseLine."No.", PurchaseLine."Lot Qty");
                //             end;
                //         end until PurchaseLine.Next() = 0;
                //     end;
                // end;
            end;
        }
    }

    var
        myInt: Integer;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

    end;
}