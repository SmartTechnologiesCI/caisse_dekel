pageextension 70031 "Purchase Credit MemoExt" extends "Purchase Credit Memo"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
                // PurchaseLine: Record "Purchase Line";
                PurchCrMemoLineTempory: Record "Purch. Cr. Memo Line Tempory";
                PurchCrMemoLineTempory2: Record "Purch. Cr. Memo Line Tempory";
            begin

                // PurchCrMemoLineTempory.DeleteAll();
                // PurchCrMemoLineTempory.Reset();
                // PurchaseLine.SetFilter("Document No.", '=%1', rec."No.");
                // PurchaseLine.SetFilter("Appl.-to Item Entry", '<>%1', 0);
                // if PurchaseLine.Findset then begin
                //     repeat begin
                //         PurchCrMemoLineTempory2.Init();
                //         PurchCrMemoLineTempory2."Appl.-to Item Entry" := PurchaseLine."Appl.-to Item Entry";
                //         // PurchCrMemoLineTempory2."Nombre de carton" := PurchaseLine."Lot Qty";
                //         PurchCrMemoLineTempory2."Appl.-to Item Entry" := PurchaseLine."Appl.-to Item Entry";
                //         PurchCrMemoLineTempory2.Insert();
                //         // Message('a:%1 b:%2', PurchCrMemoLineTempory2."Appl.-to Item Entry", PurchCrMemoLineTempory2."Nombre de carton");
                //     end until PurchaseLine.Next() = 0;

                // end;
                // Error('reviens');
            end;

            trigger OnAfterAction()
            var
                myInt: Integer;
                PurchCrMemoLine: Record "Purch. Cr. Memo Line";
                PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                PurchCrMemoLineTempory3: Record "Purch. Cr. Memo Line Tempory";
                PurchCrMemoLine2: Record "Purch. Cr. Memo Line";
                PurchCrMemoHdr2: Record "Purch. Cr. Memo Hdr.";
                PurchCrMemoLineTempory4: Record "Purch. Cr. Memo Line Tempory";
                // ItemLedgerEntry: Record "Item Ledger Entry";
            begin

                PurchCrMemoHdr.SetRange("Pre-Assigned No.", rec."No.");
                if PurchCrMemoHdr.FindFirst() then begin
                    PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
                    if PurchCrMemoLine.FindSet() then begin
                        repeat begin
                            PurchCrMemoLineTempory3.SetRange("Appl.-to Item Entry", PurchCrMemoLine."Appl.-to Item Entry");
                            if PurchCrMemoLineTempory3.FindFirst() then begin
                                // PurchCrMemoLine."Lot Qty" := -PurchCrMemoLineTempory3."Nombre de carton";
                                PurchCrMemoLine.Modify();
                                // Message('RT1:%1 RT2:%2', PurchCrMemoLine."Appl.-to Item Entry", PurchCrMemoLine."Lot Qty");
                            end;
                        end until PurchCrMemoLine.Next() = 0;
                    end;

                end;
                PurchCrMemoHdr2.SetRange("Pre-Assigned No.", rec."No.");
                if PurchCrMemoHdr2.FindFirst() then begin
                    // PurchCrMemoLine2.SetRange("Document No.", PurchCrMemoHdr2."No.");
                    // if PurchCrMemoLine2.FindSet() then begin
                    //     repeat begin
                    //         ItemLedgerEntry.SetRange("Applies-to Entry", PurchCrMemoLine2."Appl.-to Item Entry");
                    //         if ItemLedgerEntry.FindFirst() then begin
                    //             // ItemLedgerEntry."Lot Qty." := PurchCrMemoLine2."Lot Qty";
                    //             // ItemLedgerEntry.Modify();
                    //             // Message('g1:%1 g2:%2', ItemLedgerEntry."Entry No.", ItemLedgerEntry."Lot Qty.");
                    //         end;
                    //     end until PurchCrMemoLine2.Next() = 0;
                    // end;
                end;
            end;
        }
    }

    var
        myInt: Integer;
        p: Report 70014;
}