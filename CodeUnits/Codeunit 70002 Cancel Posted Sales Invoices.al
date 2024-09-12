codeunit 70002 "Cancel Psted Sles Inv."
{
    trigger OnRun()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        purch: record "Purchase Header";
        Ctest: record CronTest;
    begin
        //CorrectPostedSalesInvoice();
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange(CreditP, false);
        SalesInvoiceHeader.SetRange("Statut Livraison", SalesInvoiceHeader."Statut Livraison"::"Non payée");
        SalesInvoiceHeader.SetRange(Closed, false);
        SalesInvoiceHeader.SetRange(Cancelled, false);
        SalesInvoiceHeader.SetFilter("Due Date", '>%1', DMY2Date(07, 07, 2022));
        if SalesInvoiceHeader.FindFirst() then begin
            repeat
                CorrectPostedSalesInvoice(SalesInvoiceHeader);


                if SalesInvoiceHeader."Est Echantillone" then begin
                    purch.Reset();
                    purch.SetRange("No.", SalesInvoiceHeader."Contrat origine");
                    if purch.FindFirst() then begin
                        purch."Echantillon Douanier" -= 1;
                        purch.Modify();
                    end;
                end;
            until SalesInvoiceHeader.Next = 0;
            Clear(Ctest);
            //Ctest.ID := 1;
            // Ctest.Validated := true;
            // Ctest.Insert();
        end;

    end;



    procedure cancelCashFlowEntries(SalesInviceHader: Record 112)
    var
        encaissement: record Encaissement;
        encaissement2: record Encaissement;
        transactions: Record Transactions;
        transactions2: Record Transactions;
        depot: record Depôt;
    begin
        encaissement.Reset();
        encaissement.SetRange("N° commande", SalesInviceHader."No.");
        encaissement.SetRange(cancel, false);
        if encaissement.FindFirst() then begin
            repeat
                encaissement2.Reset();
                encaissement2.Init();
                encaissement2.Date := encaissement.Date;
                encaissement2.Heure := Time;
                encaissement2."N° commande" := SalesInviceHader."No.";
                encaissement2."N° client" := SalesInviceHader."Sell-to Customer No.";
                encaissement2."Nom client" := SalesInviceHader."Sell-to Customer Name";
                encaissement2."Mode de paiement" := encaissement2."Mode de paiement";
                encaissement2."NET a payer" := -encaissement."NET a payer";
                encaissement2."Montant NET" := -encaissement2."Montant NET";
                encaissement2.Montant := -encaissement2.Montant;
                encaissement2."Code caisse" := encaissement."Code caisse";
                encaissement2.cancel := true;
                encaissement2."Validé" := true;
                encaissement2.Insert();

                if encaissement."Mode de paiement" = 'EPARGNE' then begin
                    depot.Reset();
                    depot."N°" := 'RF' + format(Time) + SalesInviceHader."No.";
                    depot.Date := encaissement.Date;
                    depot.Heure := Time;
                    depot."N° client" := SalesInviceHader."Sell-to Customer No.";
                    depot."Nom du client" := SalesInviceHader."Sell-to Customer Name";
                    depot.Motif := 'Annulation de la facture: ' + SalesInviceHader."No.";
                    depot.Montant := encaissement."Montant NET";
                    depot."Code Caisse" := encaissement."Code caisse";
                    depot.validated := true;
                    depot.Insert();
                end
            until encaissement.Next = 0;


            transactions2.Reset();
            transactions2.SetRange("N° Document", SalesInviceHader."No.");
            transactions2.SetRange(cancel, false);
            if transactions2.FindFirst() then begin
                repeat
                    Clear(transactions);
                    transactions.Date := transactions2.Date;
                    transactions.Heure := Time;
                    transactions.Source := transactions.Source::Facture;
                    transactions."N° Document" := SalesInviceHader."No.";
                    transactions.Description := 'Annulation de la commande ' + encaissement."N° commande";
                    transactions."N° Client" := SalesInviceHader."Sell-to Customer No.";
                    transactions.Nom := SalesInviceHader."Sell-to Customer Name";
                    transactions."Mode de reglement" := encaissement."Mode de paiement";
                    transactions.Montant := -transactions2.Montant;
                    transactions."Montant recu" := -transactions2."Montant recu";
                    transactions."Montant rendu" := -transactions2."Montant rendu";
                    transactions."Montant restant" := 0;
                    transactions."Montant NET" := -transactions2."Montant NET";
                    transactions.recouvrement := transactions2.recouvrement;
                    transactions."user id" := transactions2."user id";
                    transactions."Code caisse" := transactions2."Code caisse";
                    transactions."validée" := true;
                    transactions."cancel" := true;
                    transactions.Insert();
                until transactions2.Next = 0;
            end;
        end;
    end;

    procedure CorrectPostedSalesInvoice(SalesInvoiceHeader: Record 112)
    var
        SalesHeader: Record "Sales Header";
        cancelledDoc: record "Cancelled Document";
        CorrectPostedSalesInvoice: Codeunit "Correct Posted Sales Invoice";
        //<<12_09_24
        // CU: Codeunit 70002;
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLineTempory: Record "Sales Cr.Memo Line Tempory";
        SalesCrMemoLineTempory2: Record "Sales Cr.Memo Line Tempory";
        SaleLine: Record "Sales Line";
        SaleLine2: Record "Sales Line";
        SalesShipmentHeader: Record "Sales Shipment Header";//<<Entete expéditions vente enregistrée
        SalesShipmentLine: Record "Sales Shipment Line";//<<Ligne expédition vente enregistrée
    begin
        //<<Annulation automatique des factures ventes enregistrées 12_09_24
        if not SalesCrMemoLineTempory.IsEmpty() then begin
            SalesCrMemoLineTempory.DeleteAll();
            SalesCrMemoLineTempory.Reset();
        end;
        // SalesInvoiceLine.SetFilter("Document No.", '=%1', rec."No.");
        // SalesInvoiceLine.SetFilter("Appl.-from Item Entry", '<>%1', 0);

        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        if SalesInvoiceLine.Findset then begin
            // Message('AAAA');
            // repeat begin
            SalesShipmentLine.SetRange("Order No.", SalesInvoiceLine."Order No.");
            if SalesShipmentLine.FindFirst() then begin
                repeat begin


                    SalesCrMemoLineTempory.Init();
                    SalesCrMemoLineTempory."Appl.-from Item Entry" := SalesShipmentLine."Item Shpt. Entry No.";
                    SalesCrMemoLineTempory."Nombre de carton" := SalesShipmentLine."Lot Qty";
                    SalesCrMemoLineTempory."Item Shpt. Entry No." := SalesShipmentLine."Item Shpt. Entry No.";
                    SalesCrMemoLineTempory.Insert();
                    // Message('Yes Inserted');
                end until SalesShipmentLine.Next() = 0;
            end;
            // end until SalesInvoiceLine.Next() = 0;

        end;
        //<<Annulation automatique des factures ventes enregistrées 12_09_24
        
        SalesInvoiceHeader.CalcFields(Closed);

        if SalesInvoiceHeader.Closed then begin
            //TODO: annuler l'ecriture
            CustomerLedgerEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
            if CustomerLedgerEntry.FindFirst() then begin
                DetailCustomerLedgerEntry.SetRange("Cust. Ledger Entry No.", CustomerLedgerEntry."Entry No.");
                DetailCustomerLedgerEntry.SetRange("Entry Type", DetailCustomerLedgerEntry."Entry Type"::Application);
                DetailCustomerLedgerEntry.SetRange("Document Type", DetailCustomerLedgerEntry."Document Type"::Payment);
                if DetailCustomerLedgerEntry.FindFirst() then begin
                    CustEntryApplyPostedEntries.PostUnApplyCustomer(DetailCustomerLedgerEntry, DetailCustomerLedgerEntry."Document No.", DetailCustomerLedgerEntry."Posting Date");
                end;
            end;

        end;
        ///SalesInvoiceHeader.Reset();
        //SalesInvoiceHeader.SetRange(CreditP, false);
        ///SalesInvoiceHeader.SetRange(Closed, false);
        //if not SalesInvoiceHeader.Closed and not SalesInvoiceHeader.CreditP then begin
        if CorrectPostedSalesInvoice.CreateCreditMemoCopyDocument(SalesInvoiceHeader, SalesHeader) then begin
            //PAGE.Run(PAGE::"Sales Credit Memo", SalesHeader);

            cancelCashFlowEntries(SalesInvoiceHeader);
            cancelledDoc.Reset();
            cancelledDoc."Source ID" := 112;
            cancelledDoc."Cancelled Doc. No." := SalesInvoiceHeader."No.";
            cancelledDoc."Cancelled By Doc. No." := SalesHeader."No.";
            cancelledDoc.Insert();
            SalesInvoiceHeader.Cancelled := true;
            CODEUNIT.Run(CODEUNIT::"Sales-Post (Yes/No)", SalesHeader);
            //CurrPage.Close;
            Message('Facture annulée');
            //SalesInvoiceHeader.
        end;
        //end;
    end;

    var
        vv: page 623;
        CustEntryApplyPostedEntries: Codeunit 226;
        DetailCustomerLedgerEntry: Record 379;
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
}