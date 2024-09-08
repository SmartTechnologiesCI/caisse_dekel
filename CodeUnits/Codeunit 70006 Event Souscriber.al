codeunit 70006 "Event Souscriber"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQuantityOnBeforeCheckAssocPurchOrder', '', true, true)]
    local procedure OnValidateQuantityOnBeforeCheckAssocPurchOrder(var SalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        Item: Record Item;
    begin
        Item.Reset();
        Item.SetRange("No.", SalesLine."No.");
        if Item.FindFirst() then begin
            Item.CalcFields(Inventory);
            if (Item.Inventory - SalesLine.Quantity) < -10 then begin
                Error('Le stock est biaisé, cherchez à augmenter votre stock');
            end;
        end;
    end;
    //<<24_08_2024 
    // <<Cette fonction permet d'insérer le nombre de cartons dans les écritures comptables article lors de la validation d'une commande vente 14_08_24
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLine', '', false, false)]
    local procedure OnAfterPostSalesLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var SalesInvLine: Record "Sales Invoice Line"; var SalesCrMemoLine: Record "Sales Cr.Memo Line"; var xSalesLine: Record "Sales Line")
    var
        SalesShipmentLine: Record "Sales Shipment Line";//Lignes expéditiopn vente enregistré
        // SalesLine: Record "Sales Line";
        ItemLedgerEntry: Record "Item Ledger Entry";

        ItemLedgerEntry1: Record "Item Ledger Entry";

        ItemNo: Code[20];
        VariantCode: Code[10];
        DocumentNo: Code[20];
        LineNo: Integer;

        SalesShipmentHeader1: Record "Sales Shipment line";
    begin
        // Message('Fabio be carrefull');
        SalesShipmentHeader1.SetRange("Order No.", SalesLine."Document No.");
        SalesShipmentHeader1.SetRange("Line No.", SalesLine."Line No.");

        if SalesShipmentHeader1.FindFirst() then begin
            repeat
                if ItemLedgerEntry1.get(SalesShipmentHeader1."Item Shpt. Entry No.") then begin
                    ItemLedgerEntry1."Document N°" := SalesShipmentHeader1."Order No.";
                    ItemLedgerEntry1."Lot Qty." := -SalesLine."Nombre de carton";
                    ItemLedgerEntry1.Modify();
                end;
            until SalesShipmentHeader1.Next() = 0;
        end;
    end;

    //// <<Insertion de nombre de cartons dans avoir vente enrehistré lors de l'annulation d'une vente 14_08_24
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cancel PstdSalesInv (Yes/No)", 'OnCancelInvoiceOnBeforePostedSalesCreditMemo', '', false, false)]
    local procedure OnCancelInvoiceOnBeforePostedSalesCreditMemo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var IsHandled: Boolean)
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";//Ligne avoir vente enregisté
        SalesShipmentLine: Record "Sales Shipment Line";//Ligne Expédition vente enregistré
        ItemLedgerEntry: Record "Item Ledger Entry";

    begin


        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        if SalesCrMemoLine.Findset then begin
            repeat begin

                SalesShipmentLine.SetRange("Item Shpt. Entry No.", SalesCrMemoLine."Appl.-from Item Entry");
                //SalesShipmentLine.SetRange();
                if SalesShipmentLine.FindFirst() then begin

                    SalesCrMemoLine."Nombre de carton" := SalesShipmentLine."Lot Qty";
                    SalesCrMemoLine.Modify();
                    /*   // repeat begin
                      //<<Insertion Ecriture comptable article
                      /*ItemLedgerEntry.SetRange("Entry No.", SalesShipmentLine."Item Shpt. Entry No.");
                                                     if ItemLedgerEntry.FindFirst() then begin*/
                    if ItemLedgerEntry.get(SalesShipmentLine."Item Shpt. Entry No.") then begin

                        ItemLedgerEntry."Lot Qty." := -SalesShipmentLine."Lot Qty";
                        ItemLedgerEntry.Modify();
                        // Message('N° AV:%1 N° ILE:%2 QTAV:%3 QTILE:%4', SalesShipmentLine."Item Shpt. Entry No.", ItemLedgerEntry."Entry No.", SalesShipmentLine."Lot Qty", ItemLedgerEntry."Lot Qty.");
                    end;
                    //<<Insertion Ecriture comptable article
                    // end until ItemLedgerEntry.Next() = 0; */
                end;

            end until SalesCrMemoLine.Next() = 0;
        end;
    end;

    // //<<Envoi de nombre de cartons dans écriture comptable article et facture achat enregitrée
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnAfterPost', '', true, true)]
    // local procedure OnAfterPost(var PurchaseHeader: Record "Purchase Header")
    // var
    //     PurchInvLine: Record "Purch. Inv. Line";
    //     PurchaseLine: Record "Purchase Line";
    // begin
    //     PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
    //     if PurchaseLine.FindSet() then begin

    //         PurchInvLine.SetRange("Line No.", PurchaseLine."Line No.");
    //         if PurchInvLine.FindFirst() then begin
    //             PurchInvLine."Lot Qty" := PurchaseLine."Lot Qty";
    //             PurchInvLine.Modify();
    //             // Message('a:%1 b:%2', PurchaseLine."Line No.", PurchaseLine."Lot Qty");
    //         end;
    //     end;
    //     // Message('AA');

    // end;
    [EventSubscriber(ObjectType::Table, Database::"Purch. Inv. Line", 'OnAfterInitFromPurchLine', '', false, false)]
    local procedure InsertCATaxAmt(PurchLine: Record "Purchase Line";
    var
     PurchInvLine: Record "Purch. Inv. Line")
    begin

        PurchInvLine."Lot Qty" := PurchLine."Lot Qty";
    end;


    //<<Insertion de nombre de cartons dans les avoirs achats enregistrés 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cancel PstdPurchInv (Yes/No)", 'OnBeforeShowPostedPurchaseCreditMemo', '', true, true)]
    local procedure OnBeforeShowPostedPurchaseCreditMemo(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var IsHandled: Boolean)
    var
        SalesCrMemoLine: Record "Purch. Cr. Memo Line";//Ligne avoir achat enregisté
        SalesShipmentLine: Record "Purch. Rcpt. Line";//Ligne réception achat enregistré Return Shipment Line
        ReturnShipmentLine: Record "Return Shipment Line";//Ligne Expédition achat enregistré 
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        SalesCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
        if SalesCrMemoLine.Findset then begin
            repeat begin
                //<<Insertion dans écriture comptable article
                ReturnShipmentLine.SetRange("Line No.", SalesCrMemoLine."Line No.");
                if ReturnShipmentLine.FindFirst() then begin
                    ItemLedgerEntry.SetRange("Document Line No.", ReturnShipmentLine."Line No.");
                    if ItemLedgerEntry.FindFirst() then begin
                        ItemLedgerEntry."Lot Qty." := 10;
                        ItemLedgerEntry.Modify();
                        // Message('it is the good event');
                    end;
                end;
                //<<Insertion dans écriture comptable article

                SalesShipmentLine.SetRange("Item Rcpt. Entry No.", SalesCrMemoLine."Appl.-to Item Entry");
                //SalesShipmentLine.SetRange();
                if SalesShipmentLine.FindFirst() then begin

                    SalesCrMemoLine."Lot Qty" := SalesShipmentLine."Lot Qty";
                    SalesCrMemoLine.Modify();

                    // repeat begin
                    //<<Insertion Ecriture comptable article
                    /*ItemLedgerEntry.SetRange("Entry No.", SalesShipmentLine."Item Shpt. Entry No.");
                                                   if ItemLedgerEntry.FindFirst() then begin*/
                    // if ItemLedgerEntry.get(SalesShipmentLine."Item Shpt. Entry No.") then begin
                    //     ItemLedgerEntry."Lot Qty." := -SalesShipmentLine."Lot Qty";
                    //     ItemLedgerEntry.Modify();
                    //     Message('N° AV:%1 N° ILE:%2 QTAV:%3 QTILE:%4', SalesShipmentLine."Item Shpt. Entry No.", ItemLedgerEntry."Entry No.", SalesShipmentLine."Lot Qty", ItemLedgerEntry."Lot Qty.");
                    //  end;
                    //<<Insertion Ecriture comptable article
                    // end until ItemLedgerEntry.Next() = 0;
                    // Message('Verry good Fabio');
                end;

            end until SalesCrMemoLine.Next() = 0;
        end;
    end;

    //<<Ce codeunit permet d'insérer le nombre de carton dans les avoir vente lors de la création d'un avoir correctif
    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Invoice", 'OnBeforeCreateCreditMemoOnAction', '', true, true)]
    local procedure OnBeforeCreateCreditMemoOnAction(var SalesInvoiceHeader: Record "Sales Invoice Header"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";//Lignes expéditiopn vente enregistré

    begin

        SalesLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        if SalesLine.FindSet() then begin
            Message('tche');
            repeat begin
                SalesShipmentLine.SetRange("Item Shpt. Entry No.", SalesLine."Appl.-from Item Entry");
                Message('yo');
                if SalesShipmentLine.FindFirst() then begin
                    SalesLine."Nombre de carton" := SalesShipmentLine."Lot Qty";
                    SalesLine."Item Shpt. Entry No." := SalesShipmentLine."Item Shpt. Entry No.";
                    SalesLine.Modify(true);
                    Message('Verry  goog Fabio continous');

                end;
            end until SalesLine.Next() = 0;

        end;
        // SalesHeader.SetRange("Applies-to Doc. No.",SalesInvoiceHeader."No.");
        // if SalesHeader.FindFirst() then begin
        //    SalesLine.SetRange("Document No.",sal); 
        // end;
    end;

    //<<Ajustement par feuilles articles
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnPostLinesOnAfterPostLine', '', true, true)]
    procedure OnPostLinesOnAfterPostLine(var ItemJournalLine: Record "Item Journal Line")
    var
        pesée: Record Pesse;
        ecritureCarton: record 50014;
        valentry: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        PhysInventoryLedgerEntry: Record "Phys. Inventory Ledger Entry";
        p: Page 132;
        ItemLedger: Record "Item Ledger Entry";

    //ligneArticle: record 83;
    begin
        // ItemJournalLine.SetRange(ENTR);
        // valentry:=
        // Message('Hello test:%1 b:%2', ItemJournalLine."Last Item Ledger Entry No.", ItemJournalLine."Item Shpt. Entry No.");
        // Error('tst');
        //<<Validation inventaire 21_08_24

        ItemLedgerEntry.SetRange("Document No.", ItemJournalLine."Document No.");
        ItemLedgerEntry.SetRange("Location Code", ItemJournalLine."Location Code");
        ItemLedgerEntry.SetRange("Item No.", ItemJournalLine."Item No.");//<<31_08_24
        if ItemLedgerEntry.FindFirst() then begin
            ItemLedgerEntry."Nombre de cartonc" := ItemJournalLine."Nombre de cartonc";
            ItemLedgerEntry."Diff Qty carton" := ItemJournalLine."Diff Qty carton";
            ItemLedgerEntry.Modify();
            if (ItemJournalLine."Nombre de cartonc" - ItemJournalLine."Nombre de carton") >= 0 then begin
                ItemLedgerEntry."Lot Qty." := ItemLedgerEntry."Diff Qty carton";
                ItemLedgerEntry.Modify();
            end else begin
                ItemLedgerEntry."Lot Qty." := -ItemLedgerEntry."Diff Qty carton";
                ItemLedgerEntry.Modify();
            end;
            // Message('y1:%1 y2:%2 y3:%3', ItemLedgerEntry."Lot Qty.", ItemLedgerEntry."Nombre de cartonc", ItemLedgerEntry."Diff Qty carton");
        end;
        //<<Ecriture comptable inventaire
        PhysInventoryLedgerEntry.SetRange("Document No.", ItemJournalLine."Document No.");
        PhysInventoryLedgerEntry.SetRange("Location Code", ItemJournalLine."Location Code");
        PhysInventoryLedgerEntry.SetRange("Item No.", ItemJournalLine."Item No.");//<<31_08_24
        if PhysInventoryLedgerEntry.FindFirst() then begin
            PhysInventoryLedgerEntry."Nombre de carton" := ItemJournalLine."Nombre de carton";
            PhysInventoryLedgerEntry."Nombre de cartonc" := ItemJournalLine."Nombre de cartonc";
            PhysInventoryLedgerEntry."Diff Qty carton" := ItemJournalLine."Diff Qty carton";
            PhysInventoryLedgerEntry.Modify();

            // Message('y11:%1 y22:%2 y33:%3', ItemLedgerEntry."Lot Qty.", ItemLedgerEntry."Nombre de cartonc", ItemLedgerEntry."Diff Qty carton");

            // Message('y11:%1 y22:%2 y33:%3', PhysInventoryLedgerEntry."Nombre de carton", PhysInventoryLedgerEntry."Nombre de cartonc", PhysInventoryLedgerEntry."Diff Qty carton");
        end;
        // <<Ecriture comptable inventaire
        //<<Validation inventaire 21_08_24

        //<<Transfert de stock 29_08_24
        // ItemLedger.SetRange("Document No.", ItemJournalLine."Document No.");

        // if ItemLedger.FindFirst() then begin
        //     repeat begin
        //         if ItemJournalLine."Nombre de cartonc" = 0 then begin
        //             ItemLedger."Lot Qty." := ItemJournalLine."Nombre de carton";
        //             ItemLedger.Modify();
        //             if ItemLedger."Entry Type" = ItemLedger."Entry Type"::"Negative Adjmt." then begin
        //                 ItemLedger."Lot Qty." := -ItemJournalLine."Nombre de carton";
        //                 ItemLedger.Modify();
        //             end;
        //         end;

        //     end until ItemLedger.Next() = 0;

        // end;
        //<<Transfert de stock 29_08_24
    end;
    //<<Tracking quantité en carton feuilles d'inventaires 19_08_24
    [EventSubscriber(ObjectType::Report, Report::"Calculate Inventory", 'OnAfterFunctionInsertItemJnlLine', '', true, true)]
    local procedure OnAfterFunctionInsertItemJnlLine(ItemNo: Code[20]; VariantCode2: Code[10]; DimEntryNo2: Integer; BinCode2: Code[20]; Quantity2: Decimal; PhysInvQuantity: Decimal; var ItemJournalLine: Record "Item Journal Line")
    var
        Itm: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        Totalval: Integer;
        p: Page 138;
    begin
        ItemLedgerEntry.SetRange("Item No.", ItemJournalLine."Item No.");
        ItemLedgerEntry.SetRange("Location Code", ItemJournalLine."Location Code");
        Totalval := 0;
        if ItemLedgerEntry.FindFirst() then begin
            repeat begin
                Totalval += ItemLedgerEntry."Lot Qty.";
            end until ItemLedgerEntry.Next() = 0;
            ItemJournalLine."Nombre de carton" := Totalval;
            ItemJournalLine."Nombre de cartonc" := Totalval;
            ItemJournalLine.Modify();
        end;


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Correct Posted Purch. Invoice", 'OnAfterCreateCopyDocument', '', true, true)]

    local procedure OnAfterCreateCopyDocument(var PurchaseHeader: Record "Purchase Header"; SkipCopyFromDescription: Boolean; PurchInvHeader: Record "Purch. Inv. Header")
    var
        PurchInvLine: Record "Purch. Inv. Line";//<<Ligne facture achat enregistrées
        // PurchInvLine: Record "Purch. Inv. Line";//<<Ligne facture achat enregistré
        PurchaseLine: Record "Purchase Line";//<<Ligne avoir acaht
        // PurchaseHeader: Record "Purchase Header";//<<Entete Avoir achat
        PurchRcptLine: Record "Purch. Rcpt. Line";//<<Ligne réception achat enregistrée

    begin
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then begin
            repeat begin
                PurchRcptLine.SetRange("Item Rcpt. Entry No.", PurchaseLine."Appl.-to Item Entry");
                if PurchRcptLine.FindFirst() then begin
                    PurchaseLine."Lot Qty" := PurchRcptLine."Lot Qty";

                    PurchaseLine.Modify();
                    // Message('a1:%1 b1:%2', PurchaseLine."No.", PurchaseLine."Lot Qty");
                end;
            end until PurchaseLine.Next() = 0;

        end;


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



    //<<Ordre de transfert 
    //Non encore reglé
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnAfterPost', '', true, true)]
    local procedure OnAfterPost(var TransHeader: Record "Transfer Header"; Selection: Option " ",Shipment,Receipt)
    var
        TransferShipmentLine: Record "Transfer Shipment Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TransferLine: Record "Transfer Line";
        TransferReceiptLine: Record "Transfer Receipt Line";
        ItemLedgerEntry1: Record "Item Ledger Entry";
        TransferReceiptLineTempory: Record "Transfer Receipt Line Tempory";
    begin
        // TransferLine.SetRange("Document No.",TransHeader."No.");
        // if TransferLine.Findset then begin
        //     TransferReceiptLineTempory.SetRange("Transfer Order No.",TransferLine."Document No.");
        //     TransferReceiptLineTempory.SetRange(Quantity,TransferLine.Quantity);
        //     if TransferReceiptLineTempory then begin

        //     end;
        // end;
        TransferReceiptLineTempory.SetRange("Transfer Order No.", TransHeader."No.");
        if TransferReceiptLineTempory.FindSet() then begin
            repeat begin
                ItemLedgerEntry1.SetRange("Order No.", TransferReceiptLineTempory."Transfer Order No.");
                ItemLedgerEntry1.SetRange(Open, TransferReceiptLineTempory.Open);
                ItemLedgerEntry1.SetRange(Quantity, TransferReceiptLineTempory.Quantity);
                if ItemLedgerEntry1.FindFirst() then begin
                    if ItemLedgerEntry1."Document Type" = ItemLedgerEntry1."Document Type"::"Transfer Receipt" then begin
                        ItemLedgerEntry1."Lot Qty." := TransferReceiptLineTempory."Nombre de carton";
                        ItemLedgerEntry1.Modify();
                    end;
                    if ItemLedgerEntry1."Document Type" = ItemLedgerEntry1."Document Type"::"Transfer Shipment" then begin
                        ItemLedgerEntry1."Lot Qty." := -TransferReceiptLineTempory."Nombre de carton";
                        ItemLedgerEntry1.Modify();
                    end;

                    // Message('gg:%1', ItemLedgerEntry1."Lot Qty.");
                end;
            end until TransferReceiptLineTempory.Next() = 0;
        end;
        // TransferReceiptLine.SetRange("Transfer Order No.",TransHeader."No.");
        // if TransferReceiptLine.FindFirst() then begin
        //     ItemLedgerEntry.SetRange("Order No.",TransferReceiptLine."Transfer Order No.");
        //     if ItemLedgerEntry.FindFirst() then begin
        //         ItemLedgerEntry."Lot Qty.":=TransferReceiptLine."Nombre de carton";
        //         ItemLedgerEntry.Modify();
        //         Message('thank you to God');
        //     end;
        // end;
        // TransferLine.SetRange.findf("Document No.", TransHeader."No.");
        // if TransferLine.FindFirst() then begin

        //     // Message('yes');
        //     // ItemLedgerEntry.SetRange("Document No.", TransferLine."Document No.");
        //     // if ItemLedgerEntry.FindFirst() then begin
        //     //     ItemLedgerEntry."Nombre de cartonc" := TransferLine."Nombre de carton";
        //     //     ItemLedgerEntry.Modify();
        //     //     Message('a:%1', ItemLedgerEntry."Nombre de cartonc");
        //     // end;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnBeforePost', '', true, true)]

    local procedure OnBeforePost(var TransHeader: Record "Transfer Header"; var IsHandled: Boolean; var TransferOrderPostShipment: Codeunit "TransferOrder-Post Shipment"; var TransferOrderPostReceipt: Codeunit "TransferOrder-Post Receipt"; var PostBatch: Boolean; var TransferOrderPost: Enum "Transfer Order Post")
    var
        TransferShipmentLine: Record "Transfer Shipment Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TransferLine: Record "Transfer Line";
        TransferShipmentHeader: Record "Transfer Shipment Header";
    begin
        // Message('hello1');
        // TransferLine.SetRange("Document No.", TransHeader."No.");
        // if TransferLine.FindFirst() then begin
        //     Message('test');
        //     TransferShipmentHeader.SetRange("Transfer Order No.", TransferLine."Document No.");
        //     if TransferShipmentHeader.FindFirst() then begin
        //         Message('hello man');
        //     end;
        //     // TransferShipmentLine.SetRange("Transfer Order No.", TransferLine."Document No.");
        //     // if TransferShipmentLine.FindFirst() then begin
        //     //     TransferShipmentLine."Nombre de carton" := TransferLine."Nombre de carton";
        //     //     TransferShipmentLine.Modify();
        //     //     Message('a: %1', TransferShipmentLine."Nombre de carton");
        //     //     // ItemLedgerEntry.SetRange("Document No.", TransferShipmentLine."Document No.");
        //     //     // if ItemLedgerEntry.FindFirst() then begin
        //     //     //     ItemLedgerEntry."Nombre de cartonc" := TransferShipmentLine.Quantity;
        //     //     //     ItemLedgerEntry.Modify();
        //     //     //     Message('a2:%1', ItemLedgerEntry."Nombre de cartonc");
        //     //     // end;
        //     // end;

        // end;
    end;
    //<<Ordre de transfert 07_09_24
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnCodeOnBeforePostTransferOrder', '', true, true)]
    local procedure OnCodeOnBeforePostTransferOrder(var TransHeader: Record "Transfer Header"; var DefaultNumber: Integer; var Selection: Option; var IsHandled: Boolean; var PostBatch: Boolean; var TransferOrderPost: Enum "Transfer Order Post")
    var
        TransferShipmentLine: Record "Transfer Shipment Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TransferLine: Record "Transfer Line";
        TransferShipmentHeader: Record "Transfer Shipment Header";
    begin
        // Message('hello1');
        // TransferLine.SetRange("Document No.", TransHeader."No.");
        // if TransferLine.FindFirst() then begin
        // Message('test');
        // TransferShipmentHeader.SetRange("Transfer Order No.", TransferLine."Document No.");
        // if TransferShipmentHeader.FindFirst() then begin
        //     Message('hello man');
        // end;
        // TransferShipmentLine.SetRange("Transfer Order No.", TransferLine."Document No.");
        // if TransferShipmentLine.FindFirst() then begin
        //     TransferShipmentLine."Nombre de carton" := TransferLine."Nombre de carton";
        //     TransferShipmentLine.Modify();
        //     Message('a: %1', TransferShipmentLine."Nombre de carton");
        //     // ItemLedgerEntry.SetRange("Document No.", TransferShipmentLine."Document No.");
        //     // if ItemLedgerEntry.FindFirst() then begin
        //     //     ItemLedgerEntry."Nombre de cartonc" := TransferShipmentLine.Quantity;
        //     //     ItemLedgerEntry.Modify();
        //     //     Message('a2:%1', ItemLedgerEntry."Nombre de cartonc");
        //     // end;
        // end;

        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterInsertTransShptLine', '', true, true)]
    local procedure OnAfterInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; TransShptHeader: Record "Transfer Shipment Header")
    var
        TransferShipmentLine: Record "Transfer Shipment Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TransferLine: Record "Transfer Line";
        TransferShipmentHeader: Record "Transfer Shipment Header";
    begin

        TransShptLine."Nombre de carton" := TransLine."Nombre de carton";
        TransShptLine.Modify();
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnAfterInsertTransRcptLine', '', true, true)]
    local procedure OnAfterInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header")
    var
        ItemLedgerEntry1: Record "Item Ledger Entry";
        TransferReceiptLineTempory: Record "Transfer Receipt Line Tempory";
    begin
        // ItemLedgerEntry1.LockTable(false);
        TransRcptLine."Nombre de carton" := TransLine."Nombre de carton";
        TransRcptLine.Modify();
        if not TransferReceiptLineTempory.IsEmpty then begin
            TransferReceiptLineTempory.DeleteAll();
            TransferReceiptLineTempory.Reset();
        end;
        TransferReceiptLineTempory."Item Rcpt. Entry No." := TransRcptLine."Item Rcpt. Entry No.";
        TransferReceiptLineTempory."Transfer Order No." := TransRcptLine."Transfer Order No.";
        TransferReceiptLineTempory."Nombre de carton" := TransRcptLine."Nombre de carton";
        TransferReceiptLineTempory.Quantity := TransRcptLine.Quantity;
        TransferReceiptLineTempory.Open := true;
        TransferReceiptLineTempory.Insert();
        TransferReceiptLineTempory."Item Rcpt. Entry No." := TransRcptLine."Item Rcpt. Entry No." + 1;
        TransferReceiptLineTempory."Transfer Order No." := TransRcptLine."Transfer Order No.";
        TransferReceiptLineTempory."Nombre de carton" := TransRcptLine."Nombre de carton";
        TransferReceiptLineTempory.Quantity := -TransRcptLine.Quantity;
        TransferReceiptLineTempory.Open := false;
        TransferReceiptLineTempory.Insert();
        

    end;

    




    var
        myInt: Integer;
        p: Page 138;

}