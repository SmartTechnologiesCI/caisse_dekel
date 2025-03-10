page 70030 "Encaissement"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 112;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            part("Liste des articles"; 70031)
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = suite;
            }
            group("Informations")
            {
                field("Est Echantillone"; rec."Est Echantillone")
                {
                    Caption = 'Echantillon douanier';
                    ApplicationArea = All;
                    Editable = false;
                }

            }

            group("Paiement")
            {
                group(Totaux)
                {
                    field(Amount; Amount)
                    {
                        Caption = 'Montant HT';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Montant TVA"; "Montant TVA")
                    {
                        Caption = 'Montant TVA';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Montant AIRSI"; Rec."Amount Including VAT" - Rec.Amount)
                    {
                        Caption = 'Montant AIRSI';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Amount Including VAT"; rec."Amount Including VAT")
                    {
                        Caption = 'Montant TTC';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field(TimbreOui; rec.TimbreOui)
                    {
                        Caption = 'Timbre';
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if (rec.TimbreOui) then begin
                                setTimbre();
                                //"Solde commande" += tmbre;
                                CurrPage.Update();

                            end
                            else begin
                                rec.Timbre := 0;
                                AmountandTimbre := rec."Amount Including VAT";
                                rec.Modify();
                                "Solde commande" -= tmbre;
                                CurrPage.Update();
                            end;
                        end;
                    }
                    field("Montant Timbre"; rec."Timbre")
                    {
                        Caption = 'Montant Timbre';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Net TTC"; "AmountandTimbre")
                    {
                        Caption = 'Montant NET TTC';
                        ApplicationArea = All;
                        Style = StrongAccent;
                        Editable = false;
                    }
                }
                group("Règlements")
                {
                    field("Montant payé"; "Montant payé")
                    {
                        Editable = false;
                        Caption = 'Montant réglé';
                        ApplicationArea = All;
                        Style = StrongAccent;
                    }
                    field("Remaining Amount"; "Remaining Amount")
                    {
                        Editable = false;
                        Caption = 'Solde à payer net';
                        ApplicationArea = All;
                        Style = Favorable;
                    }
                }
                group("Mode de règlement")
                {
                    field(Credit_; rec.Credit)
                    {
                        Visible = false;
                        /*ApplicationArea = All;
                        trigger OnValidate()
                        var
                            client: Record Customer;
                        begin
                            if (Credit) then begin
                                client.SetRange("No.", rec."Sell-to Customer No.");
                                if (client.FindFirst()) then begin
                                    if (client."Credit Limit (LCY)" >= "reste à payer") then
                                        "Montant credit" := "reste à payer"
                                    else
                                        Error('Ce client ne peu pas payer à crédit');
                                end
                            end
                            else
                                "Montant credit" := 0;
                        end;*/
                    }
                    field(epargne; epargne)
                    {
                        //Enabled = NOT rec.EpargneOK;
                        /*trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if epargne then
                                setEpargne()
                            else
                                unsetEpargne();
                        end;*/
                        Editable = false;
                    }
                    field("Montant credit"; "reste à payer")
                    {
                        Style = Unfavorable;
                        ApplicationArea = All;
                        Editable = false;
                        Visible = false;
                    }
                    field(depotActive; depotActive)
                    {
                        ApplicationArea = All;
                        Caption = 'Utiliser dépot';
                        trigger OnValidate()
                        var
                            depot: Record "Depôt";
                        begin
                            if (depotActive) then begin
                                depot.SetRange("N° client", "sell-to Customer No.");
                                depot.SetRange(validated, true);
                                depot.SetRange(isBonus, false);
                                if depot.FindFirst() then begin
                                    "dpt" := 0;
                                    repeat
                                        "dpt" += depot.Montant;
                                    until depot.Next = 0;
                                    if (dpt > 0) then begin
                                        if (dpt >= "Solde commande") then begin
                                            "Montant depot" := "Solde commande";
                                            "reste à payer" := 0;
                                        end
                                        else begin
                                            "Montant depot" := dpt;
                                            "reste à payer" := "Solde commande" - "Montant recu" - "Montant depot";
                                        end;
                                    end else begin
                                        Error('Le dépôt de ce client est nul');
                                    end;
                                end else begin
                                    Error('Ce client n''a pas de dépôt');
                                end
                            end else begin
                                "Montant depot" := 0;
                                "reste à payer" := "Solde commande" - "Montant recu" - "Montant depot";
                            end;
                        end;
                    }
                    //Arnaud
                    /*     field(payerDepot; payerDepot)
                         {
                             Caption = 'Payer épargne par dépôt';
                         }*/
                    field("Montant depot"; "Montant depot")
                    {
                        Editable = false;
                        Style = Strong;
                        Caption = 'Montant dépôt';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            "reste à payer" := "Solde commande" - "Montant recu" - "Montant depot";
                        end;
                    }
                    field("Mode de reglement"; "Mode de reglement")
                    {
                        ApplicationArea = All;
                        TableRelation = "Payment Method";
                        Caption = 'Autre mode de règlement';
                        Editable = NOT isEch;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if "Mode de reglement" = 'GRATUIT' then begin
                                if NOT rec."Est Echantillone" then
                                    Error('Le mode de règlement sélectionné n''est pas autorisé pour cette facture');
                            end;
                        end;
                    }
                }
                /*field("Mode de reglement"; "Mode de reglement")
                {
                    ApplicationArea = All;
                    TableRelation = "Payment Method";
                    trigger OnValidate()
                    var
                        depot: Record "Depôt";
                        customer: Record Customer;
                    begin
                        if ("Mode de reglement" = 'EPARGNE') then begin
                            depot.SetRange("N° client", "sell-to Customer No.");
                            if depot.FindFirst() then begin
                                "dpt" := 0;
                                repeat
                                    "dpt" += depot.Montant;
                                until depot.Next = 0;
                                if (dpt >= "Solde commande") then begin
                                    "Montant recu" := "Solde commande";
                                    "Monnaie à rendre" := 0;
                                    "reste à payer" := 0;
                                end
                                else begin
                                    "Montant recu" := dpt;
                                    "Monnaie à rendre" := 0;
                                    "reste à payer" := "Solde commande" - "Montant recu";
                                end;
                            end;
                            Credit := false;
                        end
                        else
                            if ("Mode de reglement" = 'CRÉDIT') then begin
                                customer.Reset();
                                customer.SetRange("No.", "Sell-to Customer No.");
                                if (customer.FindFirst()) then begin
                                    if (customer."Crédits" >= customer."Credit Limit (LCY)") then begin
                                        Message('La limite de crédit de ce client est dépassée');
                                        Error('La limite de crédit de ce client est dépassée');
                                    end
                                    else
                                        if (customer."Crédits" + AmountandTimbre > customer."Credit Limit (LCY)") then begin
                                            Message('Avec cet achat, la limite de crédit de ce client sera dépassée');
                                            Error('Avec cet achat, la limite de crédit de ce client sera dépassée');
                                        end
                                        else
                                            if (Format(customer."Last credit date") <> '') then begin
                                                if (CalcDate(customer."Limit credit time", customer."Last credit date") < WorkDate) then begin
                                                    Message('La date limite de remboursement du crédit de ce client est dépassée');
                                                    Error('La date limite de remboursement du crédit de ce client est dépassée');
                                                end;
                                            end;
                                    Credit := true;
                                    "Montant recu" := 0;
                                    "Monnaie à rendre" := 0;
                                    "reste à payer" := "Solde commande" - "Montant recu";
                                end;
                            end
                            else begin
                                Credit := false;
                                "Montant recu" := 0;
                                "Monnaie à rendre" := 0;
                                "reste à payer" := "Solde commande" - "Montant recu";
                            end;
                    end;
                }*/
                group("Encaissement")
                {
                    field("Montant recu"; "Montant recu")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        //Editable = NOT rec.Credit;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            "reste à payer" := "Solde commande";
                            if ("Montant recu" >= "reste à payer") then begin
                                "Monnaie à rendre" := "Montant recu" - "reste à payer";
                                "reste à payer" := 0;
                            end
                            else begin
                                "reste à payer" := "Solde commande" - "Montant recu" - "Montant depot";
                                "Monnaie à rendre" := 0;
                            end;
                        end;
                    }
                    field("Monnaie à rendre"; "Monnaie à rendre")
                    {
                        Style = StrongAccent;
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Montant epargne"; "Montant epargne")
                    {
                        Style = AttentionAccent;
                        ApplicationArea = All;
                        Editable = false;
                        //Visible = epargne;
                    }
                    field("Solde facture"; "Solde facture")
                    {
                        Style = StrongAccent;
                        ApplicationArea = All;
                        Editable = false;
                        //Visible = epargne;
                    }
                    field("reste à payer"; "reste à payer")
                    {
                        Style = Unfavorable;
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Solde à payer total"; "Solde à payer total")
                    {
                        Style = StrongAccent;
                        ApplicationArea = All;
                        Editable = false;
                        Visible = false;
                    }
                    field(Credit; rec.Credit)
                    {
                        Caption = 'Payer le reste à crédit';
                        trigger OnValidate()
                        var
                            client: Record Customer;
                        begin
                            client.Reset();
                            if (Credit) then begin
                                client.SetRange("No.", rec."Sell-to Customer No.");
                                if (client.FindFirst()) then begin
                                    // rec.CalcFields("Amount Including VAT");
                                    // Message('LC %1 et RP %2 MTC %3', client."Credit Limit (LCY)", "reste à payer", AmountandTimbre);
                                    //client.CalcFields("Crédits");
                                    if NOT rec."Credit exception." then begin
                                        if (client."Credit Limit (LCY)" >= "reste à payer" + client."Crédits" /*- AmountandTimbre*/) then begin
                                            client.TestField("Limit credit time");
                                            if (format(client."Last credit date") <> '') then begin
                                                if (CalcDate(client."Limit credit time" + 'J', client."Last credit date") < WorkDate) AND (client."Crédits" > 0) then
                                                    Error('Ce client est en dépacement de delai de crédit')
                                                else
                                                    "Montant credit" := "reste à payer"
                                            end;
                                        end
                                        else begin
                                            if (client."Credit Limit (LCY)" - ("reste à payer" + client."Crédits")) < 0 then
                                                Error('Ce client a dépassé sa limite de crédit où n''est pas éligible');
                                            /*else
                                                Error('Ce client a dépassé sa limite de crédit : Besoin : %1 et Disponible %2', "reste à payer", Abs(client."Credit Limit (LCY)" - ("reste à payer" + client."Crédits")));*/
                                        end;
                                    end
                                    else
                                        "Montant credit" := 0;
                                end
                            end
                            else
                                "Montant credit" := 0;
                        end;
                    }
                }
            }
        }

        area(FactBoxes)
        {
            part("Commande"; 70032)
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Valider Paiement")
            {
                Enabled = NOT "validé";
                ApplicationArea = All;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()


                var
                    Encaissement: Record Encaissement;
                    Encaissement2: Record Encaissement;
                    Encaissement3: Record Encaissement;
                    MouvTransaction1: Record "Transactions";
                    MouvTransaction2: Record "Transactions";
                    MouvTransaction3: Record "Transactions";



                    reglementEntry: Record 81;
                    reglementEntry2: Record 81;
                    reglementEntry3: Record 81;

                    reglementEntryDepot: Record 81;
                    reglementEntryDepot2: Record 81;
                    reglementEntryDepot3: Record 81;

                    reglementEntryTimbre: Record 81;
                    reglementEntryTimbre2: Record 81;
                    reglementEntryTimbre3: Record 81;
                    customer: Record Customer;
                    depot: Record "Depôt";
                    xdepot: Record "Depôt";

                    expedition: Record 110;
                    //fin silue samuel 07/03/2025 slines: Record "Sales Invoice Line";
                    saleSetup: Record "Sales & Receivables Setup";
                    client: Record Customer;
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    SaleInvHeader2: Record "Sales Invoice Header";
                    amnt: Decimal;
                begin
                    if (("reste à payer" <= 0) OR Credit) then begin
                        if (Confirm('Souhaitez-vous valider ce paiement ?')) then begin
                            Caisse.Reset();
                            Caisse.SetRange("User ID", UserId);
                            if (Caisse.FindFirst()) then begin

                                /*MouvTransaction1.Reset();
                                MouvTransaction1.Source := Source::Facture;
                                MouvTransaction1."Code caisse" := Caisse."Code caisse";
                                MouvTransaction1.Date := WorkDate;
                                MouvTransaction1.Heure := Time;
                                MouvTransaction1.Description := 'Encaissement commande ' + rec."No.";
                                MouvTransaction1.Montant := "Montant recu" - "Monnaie à rendre";
                                MouvTransaction1."Montant recu" := "Montant recu";
                                MouvTransaction1."Montant rendu" := "Monnaie à rendre";
                                MouvTransaction1."N° Document" := rec."No.";
                                MouvTransaction1."Mode de reglement" := "Mode de reglement";
                                MouvTransaction1."user id" := UserId;
                                MouvTransaction1."N° Client" := rec."Sell-to Customer No.";
                                MouvTransaction1."validée" := true;
                                MouvTransaction1.Insert();*/

                                // (); //Olivier
                                // CREDIT
                                if (Credit) then begin
                                    customer.SetRange("No.", "Sell-to Customer No.");
                                    if (customer.FindFirst()) then begin
                                        if (customer."Crédits" <= 0) then begin
                                            customer."Last credit date" := WorkDate();
                                            customer.Modify();
                                        end;
                                    end;
                                    CreditP := true;
                                    Encaissement.Reset();
                                    Encaissement."N° commande" := rec."No.";
                                    Encaissement."N° client" := "Sell-to Customer No.";
                                    Encaissement."Nom client" := "Sell-to Customer Name";
                                    Encaissement."Code caisse" := Caisse."Code caisse";
                                    Encaissement."Mode de paiement" := 'CREDIT';
                                    Encaissement."NET a payer" := "reste à payer";
                                    Encaissement."Montant NET" := 0;
                                    Encaissement."Montant" := 0;
                                    Encaissement.Monnaie := 0;
                                    Encaissement.Date := WorkDate;
                                    Encaissement.Heure := Time;
                                    Encaissement."Validé" := true;
                                    Encaissement.Reste := "reste à payer";
                                    if (rec.epargne) and (NOT rec.EpargneOK) then
                                        Encaissement.Epargne := rec."Montant epargne";
                                    Encaissement.Insert();

                                    MouvTransaction1.Reset();
                                    MouvTransaction1.Source := Source::Facture;
                                    MouvTransaction1."Code caisse" := Caisse."Code caisse";
                                    MouvTransaction1.Date := WorkDate;
                                    MouvTransaction1.Heure := Time;
                                    MouvTransaction1.Description := 'Paiement à crédit commande ' + rec."No.";
                                    MouvTransaction1.Montant := "reste à payer";
                                    MouvTransaction1."Montant recu" := 0;
                                    MouvTransaction1."Montant rendu" := 0;
                                    MouvTransaction1."Montant NET" := 0;
                                    MouvTransaction1."Montant restant" := "reste à payer";
                                    MouvTransaction1."N° Document" := rec."No.";
                                    MouvTransaction1."Mode de reglement" := 'CREDIT';
                                    MouvTransaction1."user id" := UserId;
                                    MouvTransaction1."N° Client" := rec."Sell-to Customer No.";
                                    MouvTransaction1."validée" := true;

                                    MouvTransaction1.Insert();
                                    //Commit();//olivier
                                end;
                                //Commit();
                                // TIMBRE
                                if ((TimbreOui) AND ("Montant Payé" <= 0) AND (CreditP = false)) then begin
                                    ValiderTimbre();
                                end;
                                //Commit();
                                // DEPOT
                                if (depotActive) then begin
                                    if ("Montant depot" > 0) then begin
                                        Encaissement2.Reset();
                                        Encaissement2."N° commande" := rec."No.";
                                        Encaissement2."N° client" := "Sell-to Customer No.";
                                        Encaissement2."Nom client" := "Sell-to Customer Name";
                                        Encaissement2."Code caisse" := Caisse."Code caisse";
                                        Encaissement2."Mode de paiement" := 'EPARGNE';
                                        Encaissement2."NET a payer" := AmountandTimbre;
                                        Encaissement2."Montant NET" := "Montant depot";
                                        Encaissement2."Montant" := "Montant depot";
                                        Encaissement2.Monnaie := 0;
                                        Encaissement2.Date := WorkDate;
                                        Encaissement2.Heure := Time;
                                        Encaissement2."Validé" := true;
                                        Encaissement2.Reste := "Montant credit";
                                        if (rec.epargne) and (NOT rec.EpargneOK) then
                                            Encaissement2.Epargne := rec."Montant epargne";
                                        Encaissement2.Insert();
                                        //Commit();
                                        MouvTransaction2.Reset();
                                        MouvTransaction2.Source := Source::Facture;
                                        MouvTransaction2."Code caisse" := Caisse."Code caisse";
                                        MouvTransaction2.Date := WorkDate;
                                        MouvTransaction2.Heure := Time;
                                        MouvTransaction2.Description := 'Encaissement commande paiement par depot ' + rec."No.";
                                        MouvTransaction2.Montant := AmountandTimbre;
                                        MouvTransaction2."Montant recu" := "Montant depot";
                                        MouvTransaction2."Montant rendu" := 0;
                                        MouvTransaction2."Montant NET" := "Montant depot" - "Monnaie à rendre";
                                        MouvTransaction2."N° Document" := rec."No.";
                                        MouvTransaction2."Mode de reglement" := 'EPARGNE';
                                        MouvTransaction2."user id" := UserId;
                                        MouvTransaction2."N° Client" := rec."Sell-to Customer No.";
                                        MouvTransaction2."validée" := true;
                                        if (CreditP) then
                                            MouvTransaction2.recouvrement := true;
                                        MouvTransaction2.Insert();
                                        //Commit();//Olivier
                                        ValiderDepot();
                                    end else
                                        Error('Montant dépôt doit être supérieur à 0');
                                end;
                                //Commit();
                                // PAIEMENT
                                if ("Montant recu" > 0) then begin
                                    Encaissement3.Reset();
                                    Encaissement3."N° commande" := rec."No.";
                                    Encaissement3."N° client" := "Sell-to Customer No.";
                                    Encaissement3."Nom client" := "Sell-to Customer Name";
                                    Encaissement3."Code caisse" := Caisse."Code caisse";
                                    Encaissement3."Mode de paiement" := "Mode de reglement";
                                    Encaissement3."NET a payer" := AmountandTimbre;
                                    Encaissement3."Montant NET" := "Montant recu" - "Monnaie à rendre";
                                    Encaissement3."Montant" := "Montant recu";
                                    Encaissement3.Monnaie := "Monnaie à rendre";
                                    Encaissement3.Date := WorkDate;
                                    Encaissement3.Heure := Time;
                                    Encaissement3."Validé" := true;
                                    Encaissement3.Reste := "Montant credit";
                                    if (rec.epargne) and (NOT rec.EpargneOK) then
                                        Encaissement3.Epargne := rec."Montant epargne";
                                    Encaissement3.Insert();
                                    //Commit();

                                    MouvTransaction3.Reset();
                                    MouvTransaction3.Source := Source::Facture;
                                    MouvTransaction3."Code caisse" := Caisse."Code caisse";
                                    MouvTransaction3.Date := WorkDate;
                                    MouvTransaction3.Heure := Time;
                                    MouvTransaction3.Description := 'Encaissement commande ' + rec."No.";
                                    MouvTransaction3.Montant := "Montant recu" - "Monnaie à rendre";
                                    MouvTransaction3."Montant recu" := "Montant recu";
                                    MouvTransaction3."Montant rendu" := "Monnaie à rendre";
                                    MouvTransaction3."Montant NET" := "Montant recu" - "Monnaie à rendre";
                                    MouvTransaction3."N° Document" := rec."No.";
                                    MouvTransaction3."Mode de reglement" := "Mode de reglement";
                                    MouvTransaction3."user id" := UserId;
                                    MouvTransaction3."N° Client" := rec."Sell-to Customer No.";
                                    MouvTransaction3."validée" := true;
                                    if (CreditP) then
                                        MouvTransaction3.recouvrement := true;
                                    MouvTransaction3.Insert();
                                    ValiderAutreMode();
                                end;

                                if (NOT rec.EpargneOK) AND (rec.epargne) then begin
                                    SaveEpargne();
                                end;


                                reglementEntry3.Reset();
                                reglementEntry3.SetRange("Journal Template Name", CurrentJnlTmplName);
                                reglementEntry3.SetRange("Journal Batch Name", Caisse."Code caisse");
                                //reglementEntry3.SetRange("Document No.", 'Pay' + "No.");
                                if (reglementEntry3.FindFirst()) then begin
                                    Hide := true;
                                    postLedger.OnBeforeCode(reglementEntry3, Hide);
                                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", reglementEntry3);
                                end;

                                "validé" := true;
                                if Rec."Statut Livraison" = Rec."Statut Livraison"::"Non payée" then
                                    Rec."Statut Livraison" := rec."Statut Livraison"::"Payée Non livré";
                                rec.Modify();
                                //Commit();
                                print();
                                //  Commit();
                                /* 

                                slines.SetRange("Document No.", rec."No.");
                                if slines.FindFirst() then begin
                                    repeat
                                        slines."Statut Livraison" := rec."Statut Livraison";
                                        //GET nombre de carton pour la prime bonus
                                        totalCarton += slines."Carton effectif";
                                        totalQuantite += slines.Quantity;
                                        if (rec."Statut Livraison" = rec."Statut Livraison"::"Payée totalement livré") then
                                            slines."Qté livrée" := slines."Carton effectif";

                                        slines.Modify();
                                    until slines.Next = 0;
                                end; */
                                if ("reste à payer" <= 0) then begin
                                    rec."Soldé" := true;
                                    rec.Modify();

                                    //PRIME BONUS
                                    /* saleSetup.Get();
                                     customer.SetRange("No.", Rec."Sell-to Customer No.");
                                     xdepot.FindLast();
                                     if customer.FindFirst() then begin
                                         if customer."do epargne" then begin
                                             //depot.AssistEdit_depot(depot);
                                             NoSeriesMgt.InitSeries(parCaisse."N° souche Depot", xdepot."No. Series", 0D, depot."N°", depot."No. Series");
                                             depot."N° client" := rec."Sell-to Customer No.";
                                             depot."Nom du client" := Rec."Sell-to Customer Name";
                                             depot.Motif := 'BONUS';
                                             depot.isBonus := true;
                                             depot."Code Caisse" := parCaisse.Code;
                                             depot."User ID" := rec."User ID";
                                             depot.Date := WorkDate;
                                             depot.Heure := time;
                                             //depot."Mode de paiement" := 
                                             if saleSetup."Type epargne" = saleSetup."Type epargne"::CARTON then begin
                                                 depot.Montant := totalCarton * saleSetup."Montant epargne";
                                                 depot.Insert();
                                                 //Message('Bonus octroyé');

                                             end else begin
                                                 depot.Montant := totalQuantite * saleSetup."Montant epargne";
                                                 depot.Insert();
                                                 //Message('Bonus octroyé');
                                             end;
                                             ;
                                         end;

                                     end;*/

                                end;

                                /*else
                                    if rec."Statut Livraison" = rec."Statut Livraison"::"Non payée partiellement livré" then
                                        Rec."Statut Livraison" := rec."Statut Livraison"::"Payée partiellement livré"
                                    else
                                        if rec."Statut Livraison" = rec."Statut Livraison"::"Non payée totalement livré" then
                                            Rec."Statut Livraison" := rec."Statut Livraison"::"Payée totalement livré";*/

                                //Rec."Statut Livraison" := Rec."Statut Livraison"::"Non livré";
                                //
                                expedition.SetRange("Order No.", rec."Order No.");
                                if expedition.FindFirst() then begin
                                    expedition."Invoice No." := Rec."No.";
                                    expedition."Payment DateTime" := CurrentDateTime;
                                    expedition."Statut livraison" := expedition."Statut livraison"::"Payée Non livré";
                                    expedition.Modify();
                                end;
                                //


                                //  NoSeriesMgt.TestManual(parCaisse."N° souche Depot");
                                //depot."No. Series" := '';
                                /*if xRec."No Point" = '' then
                                    "Costing Method" := InvtSetup."Default Costing Method";*/


                                cutomer.Reset();

                                cutomer.SetRange("No.", clientNo);
                                if cutomer.FindFirst() then begin
                                    SaleInvHeader2.Reset();
                                    SaleInvHeader2.SetRange("Sell-to Customer No.", cutomer."No.");
                                    SaleInvHeader2.setRange(CreditP, true);
                                    SaleInvHeader2.SetRange(Closed, false);
                                    amnt := 0;
                                    if SaleInvHeader2.FindFirst() then begin
                                        repeat
                                            SaleInvHeader2.CalcFields("Remaining Amount");
                                            amnt += SaleInvHeader2."Remaining Amount";
                                        until SaleInvHeader2.Next = 0;
                                    end;
                                    cutomer."Crédits" := amnt;
                                    if amnt = 0 then
                                        cutomer."Last credit date" := 0D;

                                    cutomer.Modify();

                                    //  Message('Yes');
                                    // CurrPage.Update();

                                end;




                                CurrPage.Close();
                            end else
                                error('Aucune caisse n''est définie');
                        end;
                    end else
                        Error('La commande n''est pas totalement payée');
                end;
            }
            action("Imprimer reçu")
            {

                Enabled = NOT "validé";
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                begin
                    print();
                end;
            }
        }
    }

    local procedure SaveEpargne()
    var
        saleSetup: record "Sales & Receivables Setup";
        customer: Record Customer;
        xdepot: Record "Depôt";
        depot: Record "Depôt";
        depot2: Record "Depôt";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MouvTransaction3: Record Transactions;
    begin
        saleSetup.Get();
        customer.SetRange("No.", Rec."Sell-to Customer No.");
        if customer.FindFirst() then begin
            //   if customer."Dépôts" >= rec."Montant epargne" then begin //olivier
            //if customer."do epargne" then begin
            //depot.AssistEdit_depot(depot);
            Clear(xdepot);
            clear(depot);
            xdepot.FindLast();
            NoSeriesMgt.InitSeries(parCaisse."N° souche Depot", xdepot."No. Series", 0D, depot."N°", depot."No. Series");
            depot.Reset();
            depot."N° client" := rec."Sell-to Customer No.";
            depot."Nom du client" := Rec."Sell-to Customer Name";
            depot.Motif := 'EPARGNE SPECIAL';
            depot.isBonus := true;
            depot."Code Caisse" := Caisse."Code caisse";
            depot."User ID" := UserId;
            depot.Date := WorkDate;
            // if (payerDepot) /*and (CompanyName = 'TULIPE')*/ then
            //      depot."Mode de paiement" := 'DEPOT'
            //  else
            depot."Mode de paiement" := 'ESPÈCES';
            depot.Heure := time;
            //depot."Mode de paiement" := 
            depot.Montant := rec."Montant epargne";
            depot.validated := true;
            depot.Insert();
            rec.EpargneOK := true;
            rec.Modify();

            //end;


            MouvTransaction3.Reset();
            MouvTransaction3.Source := Source::Facture;
            MouvTransaction3."Code caisse" := Caisse."Code caisse";
            MouvTransaction3.Date := WorkDate;
            MouvTransaction3.Heure := Time;
            MouvTransaction3.Description := 'EPARGNE SPECIAL';
            MouvTransaction3.Montant := "Montant epargne";
            MouvTransaction3."Montant recu" := "Montant epargne";
            MouvTransaction3."Montant rendu" := 0;
            MouvTransaction3."Montant NET" := "Montant epargne";
            MouvTransaction3."N° Document" := rec."No.";

            // if (payerDepot) /*and (CompanyName = 'TULIPE')*/ then
            //     MouvTransaction3."Mode de reglement" := 'DEPOT'
            //  else
            MouvTransaction3."Mode de reglement" := 'ESPÈCES';
            MouvTransaction3."user id" := UserId;
            MouvTransaction3."N° Client" := rec."Sell-to Customer No.";
            MouvTransaction3."validée" := true;
            MouvTransaction3.Insert();


            // if (payerDepot) /*and (CompanyName = 'TULIPE')*/ then begin
            /*
                            Clear(xdepot);
                            xdepot.FindLast();
                            clear(depot2);
                            NoSeriesMgt.InitSeries(parCaisse."N° souche Depot", xdepot."No. Series", 0D, depot2."N°", depot2."No. Series");
                            depot2.Reset();
                            depot2."N° client" := rec."Sell-to Customer No.";
                            depot2."Nom du client" := Rec."Sell-to Customer Name";
                            depot2.Motif := 'PAIEMENT EPARGNE SPECIAL';
                            depot2.isBonus := false; //Défini si il s'agit d'une epargne ou non! là on met a false pcq il d'un dépot tout court pas d'une epargne
                            depot2."Code Caisse" := Caisse."Code caisse";
                            depot2."User ID" := UserId;
                            depot2.Date := WorkDate;
                            depot2.Heure := time;
                            //depot."Mode de paiement" 
                            depot2.Montant := -rec."Montant epargne";
                            depot2.validated := true;
                            //depot.
                            depot2.Insert();

                        end;*/


            //end else begin
            //  Error('Le dépôt ne suffit pas pour payer l''épargne');
            //end;
        end;
    end;



    trigger OnOpenPage()
    var
        ouverture: Record "Ouverture de caisse";
        SaleInvHeader: Record "Sales Invoice Header";
        SaleInvHeader2: Record "Sales Invoice Header";
        amnt: Decimal;
    begin
        clientNo := rec."Sell-to Customer No.";
        "Mode de reglement" := 'ESPÈCES';
        Caisse.Reset();
        Caisse.SetRange("User ID", UserId);
        Caisse.FindFirst();
        ;
        parCaisse.Reset();
        parCaisse.Get();
        ;
        rec.TimbreOui := true;
        rec.Validate(TimbreOui);
        setTimbre();
        ouverture.SetRange("Code caisse", Caisse."Code caisse");
        ouverture.SetRange("Date ouverture", WorkDate);
        ouverture.SetRange(status, ouverture.status::Validated);
        if (NOT ouverture.FindFirst()) then
            Error('Veuillez créer et valider une ouverture de caisse pour la journée');
        CurrPage.Update();
        cutomer.Reset();

        cutomer.SetRange("No.", rec."Sell-to Customer No.");
        if cutomer.FindFirst() then begin
            SaleInvHeader2.Reset();
            SaleInvHeader2.SetRange("Sell-to Customer No.", cutomer."No.");
            SaleInvHeader2.setRange(CreditP, true);
            SaleInvHeader2.SetRange(Closed, false);
            amnt := 0;
            if SaleInvHeader2.FindFirst() then begin
                repeat
                    SaleInvHeader2.CalcFields("Remaining Amount");
                    amnt += SaleInvHeader2."Remaining Amount";
                until SaleInvHeader2.Next = 0;
            end;
            if rec.EpargneOK then rec.epargne := true;
            cutomer."Crédits" := amnt;
            cutomer.Modify();
            CurrPage.Update();


            isEch := rec."Est Echantillone";

            if rec."Est Echantillone" then begin
                "Mode de reglement" := 'GRATUIT';
            end else
                "Mode de reglement" := 'ESPÈCES';
        end;

    end;

    trigger OnAfterGetRecord()
    var
        parCompta: Record 98;
        rnd: integer;
    begin
        parCompta.get();
        rnd := 5;
        "validé" := false;
        // silue samuel 07/03/2025 "Montant AIRSI" := rec."Amount Including VAT" * (1 - (1 / (1 + parCompta."% AIRSI" / 100)));
        // fin silue samuel 07/03/2025 "Montant TVA" := (rec."Amount Including VAT" / (1 + parCompta."% AIRSI" / 100)) * (1 - (1 / (1 + parCompta."% TVA" / 100)));
        //         
        //
        if (TimbreOui) then setTimbre();
        "Solde commande" := "Remaining Amount" + rec.timbre;
        "Solde facture" := "Remaining Amount" + rec.timbre;
        "Montant Payé" := AmountandTimbre - ("Remaining Amount" + timbre + "Montant epargne");
        "reste à payer" := "Solde commande" - "Montant recu" - "Montant depot";
        "Solde à payer total" := "Solde commande" - "Montant recu" - "Montant depot" + "Montant epargne";
        IF "Solde commande" MOD rnd <> 0 THEN
            "Solde commande" += rnd - ("Solde commande" MOD rnd);
        IF "Montant Payé" MOD rnd <> 0 THEN
            "Montant Payé" += rnd - ("Montant Payé" MOD rnd);
        IF "reste à payer" > 0 then begin
            IF "reste à payer" MOD rnd <> 0 THEN
                "reste à payer" += rnd - ("reste à payer" MOD rnd);
        end;

        CurrPage.Update();
    end;


    local procedure ValiderDepot()
    var
        depot: Record "Depôt";

        reglementEntryDepot: Record 81;
        reglementEntryDepot2: Record 81;
    begin
        //Ecriture sortie dépôt
        if "Montant depot" > 0 then begin
            depot."N°" := 'RT' + format(time) + "No.";
            depot.Reset();
            depot.Date := WorkDate;
            depot.Heure := time;
            depot."Mode de paiement" := '';
            depot.Montant := -"Montant depot";
            depot.Motif := 'Encaissement commande ' + rec."No.";
            depot."Nom du client" := rec."Sell-to Customer Name";
            depot."N° client" := rec."Sell-to Customer No.";
            depot."Code Caisse" := Caisse."Code caisse";
            depot."User ID" := UserID;
            depot.validated := true;

            depot.Insert();
            //Commit();

            reglementEntryDepot.Reset();
            reglementEntryDepot2.Reset();

            reglementEntryDepot2.SetRange("Journal Template Name", 'REGLEMENT');
            reglementEntryDepot2.SetRange("Journal Batch Name", Caisse."Code caisse");
            if (reglementEntryDepot2.FindLast()) then
                LineNo := reglementEntryDepot2."Line No." + 10000
            else
                LineNo := 10000;
            reglementEntryDepot.Reset();
            reglementEntryDepot."Journal Template Name" := 'REGLEMENT';
            reglementEntryDepot.Validate("Journal Template Name");
            reglementEntryDepot."Journal Batch Name" := Caisse."Code caisse";
            reglementEntryDepot.Validate("Journal Batch Name");
            reglementEntryDepot."Line No." := LineNo;
            reglementEntryDepot."Posting Date" := WorkDate;
            reglementEntryDepot.Validate("Posting Date");
            reglementEntryDepot."Document Type" := reglementEntryDepot."Document Type"::Refund;
            reglementEntryDepot.Validate("Document Type");
            reglementEntryDepot."Document No." := 'Pay' + rec."No." + '-' + CopyStr(format(Time), 1, 5);
            reglementEntryDepot.Validate("Document No.");
            reglementEntryDepot."Source Code" := 'VTEREGLT';
            reglementEntryDepot."Account Type" := reglementEntryDepot."Account Type"::"Customer";
            reglementEntryDepot.Validate("Account Type");
            reglementEntryDepot."Account No." := rec."Sell-to Customer No.";
            reglementEntryDepot.Validate("Account No.");
            reglementEntryDepot.Description := 'Paiement de la facture: ' + rec."No.";
            reglementEntryDepot."Bal. Account Type" := reglementEntryDepot."Bal. Account Type"::"Bank Account";
            reglementEntryDepot."Bal. Account No." := parCaisse."N° compte coffre fort";
            reglementEntryDepot.Validate("Bal. Account No.");
            reglementEntryDepot.Amount := "Montant depot";
            reglementEntryDepot."Amount (LCY)" := "Montant depot";
            reglementEntryDepot.Validate(Amount);
            reglementEntryDepot."Debit Amount" := "Montant depot";
            reglementEntryDepot.Validate("Debit Amount");
            if "Montant depot" > 0 then begin
                reglementEntryDepot.Insert()
            end else
                Error('Montant du dépot doit être supérieur à zéro');


            reglementEntryDepot.Reset();
            reglementEntryDepot2.Reset();

            reglementEntryDepot2.SetRange("Journal Template Name", 'REGLEMENT');
            reglementEntryDepot2.SetRange("Journal Batch Name", Caisse."Code caisse");
            if (reglementEntryDepot2.FindLast()) then
                LineNo := reglementEntryDepot2."Line No." + 10000
            else
                LineNo := 10000;
            reglementEntryDepot.Reset();
            reglementEntryDepot."Journal Template Name" := 'REGLEMENT';
            reglementEntryDepot.Validate("Journal Template Name");
            reglementEntryDepot."Journal Batch Name" := Caisse."Code caisse";
            reglementEntryDepot.Validate("Journal Batch Name");
            reglementEntryDepot."Line No." := LineNo;
            reglementEntryDepot."Posting Date" := WorkDate;
            reglementEntryDepot.Validate("Posting Date");
            reglementEntryDepot."Document Type" := reglementEntryDepot."Document Type"::Payment;
            reglementEntryDepot.Validate("Document Type");
            reglementEntryDepot."Document No." := 'Pay' + rec."No." + '-' + CopyStr(format(Time), 1, 5);
            reglementEntryDepot.Validate("Document No.");
            reglementEntryDepot."Source Code" := 'VTEREGLT';
            reglementEntryDepot."Account Type" := reglementEntryDepot."Account Type"::"Bank Account";
            reglementEntryDepot.Validate("Account Type");
            reglementEntryDepot."Account No." := caisse."Code caisse";
            reglementEntryDepot.Validate("Account No.");
            reglementEntryDepot.Description := 'Paiement de la facture: ' + rec."No.";
            reglementEntryDepot."Bal. Account Type" := reglementEntryDepot."Bal. Account Type"::Customer;
            reglementEntryDepot."Bal. Account No." := "Sell-to Customer No.";
            reglementEntryDepot.Validate("Bal. Account No.");

            reglementEntryDepot."Applies-to Doc. Type" := reglementEntryDepot."Applies-to Doc. Type"::Invoice;
            reglementEntryDepot."Applies-to Doc. No." := "No.";
            reglementEntryDepot.Validate("Applies-to Doc. No.");
            reglementEntryDepot."Applied Automatically" := true;

            reglementEntryDepot.Amount := "Montant depot";
            reglementEntryDepot."Amount (LCY)" := "Montant depot";
            reglementEntryDepot.Validate(Amount);
            reglementEntryDepot."Debit Amount" := "Montant depot";
            reglementEntryDepot.Validate("Debit Amount");
            if "Montant depot" > 0 then
                reglementEntryDepot.Insert();
        end else
            Error('Montant du dépot doit être supérieur à zéro');
    end;

    local procedure ValiderTimbre()
    var
        reglementEntryTimbre: Record 81;
        reglementEntryTimbre2: Record 81;
    begin
        if Timbre > 0 then begin
            reglementEntryTimbre.Reset();
            reglementEntryTimbre2.Reset();
            reglementEntryTimbre2.SetRange("Journal Template Name", CurrentJnlTmplName);
            reglementEntryTimbre2.SetRange("Journal Batch Name", Caisse."Code caisse");
            if (reglementEntryTimbre2.FindLast()) then
                LineNo := reglementEntryTimbre2."Line No." + 10000
            else
                LineNo := 10000;
            reglementEntryTimbre.Reset();
            reglementEntryTimbre."Journal Template Name" := CurrentJnlTmplName;
            reglementEntryTimbre.Validate("Journal Template Name");
            reglementEntryTimbre."Journal Batch Name" := Caisse."Code caisse";
            reglementEntryTimbre.Validate("Journal Batch Name");
            reglementEntryTimbre."Line No." := LineNo;
            reglementEntryTimbre."Posting Date" := WorkDate;
            reglementEntryTimbre.Validate("Posting Date");
            reglementEntryTimbre."Document Type" := reglementEntryTimbre."Document Type"::Refund;
            reglementEntryTimbre.Validate("Document Type");
            reglementEntryTimbre."Document No." := 'Pay' + "No." + '-' + CopyStr(format(Time), 1, 5);
            reglementEntryTimbre."Source Code" := 'VTEREGLT';
            reglementEntryTimbre.Validate("Document No.");
            reglementEntryTimbre."Account Type" := reglementEntryTimbre."Account Type"::"G/L Account";
            reglementEntryTimbre.Validate("Account Type");
            reglementEntryTimbre."Account No." := '442830';
            reglementEntryTimbre.Validate("Account No.");
            reglementEntryTimbre.Description := 'TIMBRE';
            reglementEntryTimbre."Bal. Account Type" := reglementEntryTimbre."Bal. Account Type"::Customer;
            reglementEntryTimbre."Bal. Account No." := "Sell-to Customer No.";
            reglementEntryTimbre."Gen. Posting Type" := reglementEntryTimbre."Gen. Posting Type"::Sale;
            /*reglementEntryTimbre."Applies-to Doc. Type" := reglementEntryTimbre."Applies-to Doc. Type"::Invoice;
            reglementEntryTimbre."Applies-to Doc. No." := "No.";
            reglementEntryTimbre.Validate("Applies-to Doc. No.");
            reglementEntryTimbre."Applied Automatically" := true;*/
            reglementEntryTimbre."Source Code" := 'UIIa';

            reglementEntryTimbre.Amount := -Timbre;
            reglementEntryTimbre."Amount (LCY)" := -Timbre;
            reglementEntryTimbre.Validate(Amount);
            reglementEntryTimbre."Debit Amount" := -Timbre;
            reglementEntryTimbre.Validate("Debit Amount");
            reglementEntryTimbre.Correction := false;
            if Timbre > 0 then
                reglementEntryTimbre.Insert();

        end else
            Error('Montant Timbre doit être supérieur à zéro');
    end;

    local procedure ValiderAutreMode()
    var
        reglementEntry: Record 81;
        reglementEntry2: Record 81;
        reglementEntry3: Record 81;
    begin
        if "Montant recu" > 0 then begin
            reglementEntry2.SetRange("Journal Template Name", CurrentJnlTmplName);
            reglementEntry2.SetRange("Journal Batch Name", Caisse."Code caisse");
            if (reglementEntry2.FindLast()) then
                LineNo := reglementEntry2."Line No." + 10000
            else
                LineNo := 10000;
            reglementEntry.Reset();
            reglementEntry."Journal Template Name" := CurrentJnlTmplName;
            reglementEntry.Validate("Journal Template Name");
            reglementEntry."Journal Batch Name" := Caisse."Code caisse";
            reglementEntry.Validate("Journal Batch Name");
            reglementEntry."Line No." := LineNo;
            reglementEntry."Posting Date" := WorkDate;
            reglementEntry.Validate("Posting Date");
            reglementEntry."Document Type" := reglementEntry."Document Type"::Payment;
            reglementEntry.Validate("Document Type");
            reglementEntry."Document No." := 'Pay' + "No." + '-' + CopyStr(format(Time), 1, 5);
            reglementEntry.Validate("Document No.");
            reglementEntry."Source Code" := 'VTEREGLT';
            if ("Mode de reglement" = 'ESPÈCES') then begin
                reglementEntry."Account Type" := reglementEntry."Account Type"::"Bank Account";
                reglementEntry.Validate("Account Type");
                reglementEntry."Account No." := Caisse."Code caisse";
                reglementEntry.Validate("Account No.");
            end else
                if ("Mode de reglement" = 'VIREMENT') then begin
                    reglementEntry."Account Type" := reglementEntry."Account Type"::"Bank Account";
                    reglementEntry.Validate("Account Type");
                    reglementEntry."Account No." := parCaisse."N° compte banque virement";
                    reglementEntry.Validate("Account No.");
                end else
                    if ("Mode de reglement" = 'CHEQUE') then begin
                        reglementEntry."Account Type" := reglementEntry."Account Type"::"Bank Account";
                        reglementEntry.Validate("Account Type");
                        reglementEntry."Account No." := parCaisse."N° compte banque cheque";
                        reglementEntry.Validate("Account No.");
                    end else
                        if ("Mode de reglement" = 'GRATUIT') then begin
                            reglementEntry."Account Type" := reglementEntry."Account Type"::"Bank Account";
                            reglementEntry.Validate("Account Type");
                            reglementEntry."Account No." := parCaisse."N° compte banque virement";
                            reglementEntry.Validate("Account No.");
                        end;

            reglementEntry.Description := 'PAIEMENT DE LA FACTURE ' + "No." + ' (' + Caisse."Code caisse" + ')';
            reglementEntry."Bal. Account Type" := reglementEntry."Bal. Account Type"::Customer;
            reglementEntry."Bal. Account No." := "Sell-to Customer No.";

            reglementEntry."Applies-to Doc. Type" := reglementEntry."Applies-to Doc. Type"::Invoice;
            reglementEntry."Applies-to Doc. No." := "No.";
            reglementEntry.Validate("Applies-to Doc. No.");
            reglementEntry."Applied Automatically" := true;


            reglementEntry.Amount := "Montant recu" - "Monnaie à rendre";
            reglementEntry."Amount (LCY)" := "Montant recu" - "Monnaie à rendre";
            reglementEntry.Validate(Amount);
            reglementEntry."Debit Amount" := "Montant recu" - "Monnaie à rendre";
            reglementEntry.Validate("Debit Amount");
            if ("Montant recu" - "Monnaie à rendre") > 0 then
                reglementEntry.Insert();
        end else
            Error('Montant reçu doit être supérieur à zéro');
    end;

    local procedure print()
    var
        Encaissement2: record Encaissement;
        Encaissement3: record Encaissement;
    begin
        Commit(); // olivier
        Encaissement2.Reset();
        Encaissement2.SetCurrentKey("N°");
        Encaissement2.SetRange("N° commande", rec."No.");
        Encaissement2.SetRange(Date, WorkDate()); //olivier 04/12/2022
        Encaissement2.SetRange("N° client", rec."Sell-to Customer No.");
        if (Encaissement2.FindLast()) then begin
            if rec.NbImpression = 0 then begin
                Encaissement3.Reset();
                Encaissement3.SetRange("N° commande", rec."No.");
                Encaissement3.SetRange(Date, WorkDate()); //olivier 04/12/2022
                Encaissement3.SetRange("N° client", rec."Sell-to Customer No.");
                Encaissement3.SetRange("N°", Encaissement2."N°");
                if Encaissement3.FindLast() then begin
                    Report.Run(70023, true, false, Encaissement2);
                    rec.NbImpression := rec.NbImpression + 1;
                end;
            end
            else begin
                Encaissement3.Reset();
                Encaissement3.SetRange("N° commande", rec."No.");
                Encaissement3.SetRange(Date, WorkDate()); //olivier 04/12/2022
                Encaissement3.SetRange("N° client", rec."Sell-to Customer No.");
                Encaissement3.SetRange("N°", Encaissement2."N°");
                if Encaissement3.FindLast() then begin

                    Report.Run(70027, true, false, Encaissement3);
                end;


            end;


        end;
    end;




    var
        // etat: Report 204;
        totalCarton: Decimal;
        totalQuantite: Decimal;
        "postLedger": Codeunit 70000;
        "Montant TVA": Decimal;
        "Montant Payé": Decimal;
        //"Montant epargne": Decimal;
        "Montant AIRSI": Decimal;
        "AmountandTimbre": Decimal;
        "tmbre": Decimal;
        "Mode de reglement": code[30];
        "Montant credit": Decimal;
        "Montant depot": Decimal;
        "Montant recu": Decimal;
        "Monnaie à rendre": Decimal;
        "reste à payer": Decimal;
        "Solde à payer total": Decimal;
        "Solde commande": Decimal;
        "Solde facture": Decimal;
        "dpt": Decimal;
        "validé": Boolean;
        //"epargne": Boolean;
        cutomer: record customer;
        "Caisse": Record caisse;
        "LineNo": Integer;
        "Hide": Boolean;
        "depotActive": Boolean;
        CurrentJnlTmplName: TextConst FRA = 'REGLEMENT';
        parCaisse: Record "Parametres caisse";
        isEch: Boolean;
        clientNo: Code[20];
    //  payerDepot: Boolean;


    procedure setTimbre()
    var
    begin
        if (("Amount Including VAT" >= 5000) AND ("Amount Including VAT" < 100000)) then begin
            Timbre := 100;
        end
        else
            if (("Amount Including VAT" >= 100001) AND ("Amount Including VAT" < 500000)) then begin
                Timbre := 500;
            end
            else
                if (("Amount Including VAT" >= 500001) AND ("Amount Including VAT" < 1000000)) then begin
                    Timbre := 1000;
                end
                else
                    if (("Amount Including VAT" >= 1000001) AND ("Amount Including VAT" < 5000000)) then begin
                        Timbre := 2000;
                    end
                    else
                        if (("Amount Including VAT" > 5000000)) then begin
                            Timbre := 5000;
                        end;
        Validate(Timbre);
        AmountandTimbre := "Amount Including VAT" + Timbre + "Montant epargne";
        tmbre := Timbre;
        "Solde commande" += tmbre;
        Modify();
    end;
}