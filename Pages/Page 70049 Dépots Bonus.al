page 70049 "Dépots bonus"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    Editable = false;
    Caption = 'Epargnes client';
    layout
    {
        area(Content)
        {
            group("Soldes clients")
            {
                repeater("")
                {
                    field("No."; rec."No.")
                    {
                        ApplicationArea = All;

                    }
                    field("Name"; rec.Name)
                    {
                        ApplicationArea = All;

                    }

                    field("Montant prime bonus"; rec."Montant prime bonus")
                    {
                        Caption = 'Total Epargne';
                        ApplicationArea = All;
                        trigger OnDrillDown()
                        var
                            depot: Record "Depôt";
                        begin
                            depot.setRange("N° client", rec."No.");
                            depot.setRange(isBonus, true);
                            if depot.FindFirst() then begin
                                Page.Run(70079, depot);
                            end;
                        end;

                    }
                }
            }

            field("Total"; "Total")
            {

            }

        }
    }

    actions
    {
        area(Processing)
        {

            action("Transferer Bonus")
            {
                Caption = 'transférer épargne vers dépôts';
                Image = TransferFunds;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    customer: Record Customer;
                    depot: Record "Depôt";
                    depot2: Record "Depôt";
                    xdepot: Record "Depôt";
                    Tempdepot: Record "Depôt";
                    custemp: Record Customer;
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    parCaisse: Record "Parametres caisse";
                    mtn: Integer;
                begin
                    if (NOT Confirm('Vous allez transférer l''épargne  du/des client(s) vers les comptes dépôts. Continuer?', true)) then
                        exit;


                    CurrPage.SetSelectionFilter(custemp);
                    custemp.Next();
                    if custemp.FindFirst() then begin
                        repeat


                            mtn := 0;
                            depot2.Reset();
                            depot2.SetRange("N° client", custemp."No.");
                            depot2.SetRange(isBonus, true);
                            if depot2.FindFirst() then begin
                                repeat
                                    mtn += depot2.Montant;
                                until depot2.Next = 0;
                            end;
                            if parCaisse.Get() then;

                            //Ecriture Dépôt montant >0
                            Clear(xdepot);
                            clear(depot);
                            xdepot.FindLast();
                            NoSeriesMgt.InitSeries(parCaisse."N° souche Depot", xdepot."No. Series", 0D, depot."N°", depot."No. Series");
                            depot.Reset();
                            depot."N° client" := custemp."No.";
                            depot."Nom du client" := custemp.Name;
                            depot.Motif := 'TRANSFERT EPARGNE';
                            depot.isBonus := false;
                            depot."User ID" := UserId;
                            depot.Date := WorkDate;
                            depot."Mode de paiement" := 'EPARGNE';
                            depot.Heure := time;
                            depot.Montant := mtn;
                            depot.validated := true;
                            depot.Insert();


                            //Ecriture Dépôt montant < 0
                            Clear(xdepot);
                            clear(depot);
                            xdepot.FindLast();
                            NoSeriesMgt.InitSeries(parCaisse."N° souche Depot", xdepot."No. Series", 0D, depot."N°", depot."No. Series");
                            depot.Reset();
                            depot."N° client" := custemp."No.";
                            depot."Nom du client" := custemp.Name;
                            depot.Motif := 'TRANSFERT EPARGNE';
                            depot.isBonus := true;
                            depot."User ID" := UserId;
                            depot.Date := WorkDate;
                            depot."Mode de paiement" := 'EPARGNE';
                            depot.Heure := time;
                            depot.Montant := -mtn;
                            depot.validated := true;
                            depot.Insert();


                        until custemp.Next() = 0;

                        Message('transfert terminé');
                        CurrPage.Update();
                    end;

                end;
            }
            action("Transferer Bonus All")
            {
                Caption = 'transférer épargne vers dépôts Tous les clients';
                Image = TransferFunds;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                var
                    customer: Record Customer;
                    depot: Record "Depôt";
                    depot2: Record "Depôt";
                    xdepot: Record "Depôt";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    parCaisse: Record "Parametres caisse";
                    mtn: Integer;
                begin
                    if (NOT Confirm('Vous allez transférer l''épargne des client vers les comptes de dépôts. Continuer?', true)) then
                        exit;

                    customer.Reset();
                    if (customer.FindFirst()) then begin
                        mtn := 0;
                        depot2.Reset();
                        depot2.SetRange("N° client", Rec."No.");
                        depot2.SetRange(isBonus, true);
                        if depot2.FindFirst() then begin
                            repeat
                                mtn += depot2.Montant;
                            until depot2.Next = 0;
                        end;

                        if parCaisse.Get() then;

                        //Ecriture Dépôt montant >0
                        Clear(xdepot);
                        clear(depot);
                        xdepot.FindLast();
                        NoSeriesMgt.InitSeries(parCaisse."N° souche Depot", xdepot."No. Series", 0D, depot."N°", depot."No. Series");
                        depot.Reset();
                        depot."N° client" := rec."No.";
                        depot."Nom du client" := Rec.Name;
                        depot.Motif := 'TRANSFERT EPARGNE';
                        depot.isBonus := false;
                        depot."User ID" := UserId;
                        depot.Date := WorkDate;
                        depot."Mode de paiement" := 'EPARGNE';
                        depot.Heure := time;
                        depot.Montant := mtn;
                        depot.validated := true;
                        depot.Insert();


                        //Ecriture Dépôt montant < 0
                        Clear(xdepot);
                        clear(depot);
                        xdepot.FindLast();
                        NoSeriesMgt.InitSeries(parCaisse."N° souche Depot", xdepot."No. Series", 0D, depot."N°", depot."No. Series");
                        depot.Reset();
                        depot."N° client" := rec."No.";
                        depot."Nom du client" := Rec.Name;
                        depot.Motif := 'TRANSFERT EPARGNE';
                        depot.isBonus := true;
                        depot."User ID" := UserId;
                        depot.Date := WorkDate;
                        depot."Mode de paiement" := 'EPARGNE';
                        depot.Heure := time;
                        depot.Montant := -mtn;
                        depot.validated := true;
                        depot.Insert();


                        Message('transfert terminé');
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        customer: record Customer;
    begin
    end;

    trigger OnAfterGetRecord()
    var
        SaleInvHeader: Record "Sales Invoice Header";
        amnt: Decimal;
        DirectorCue: Record "Director Cue";
    begin
        SaleInvHeader.SetRange("Sell-to Customer No.", "No.");
        SaleInvHeader.setRange(CreditP, true);
        SaleInvHeader.SetRange(Closed, false);
        amnt := 0;
        if SaleInvHeader.FindFirst() then begin
            repeat
                SaleInvHeader.CalcFields("Remaining Amount");
                amnt += SaleInvHeader."Remaining Amount";
            until SaleInvHeader.Next = 0;
        end;
        rec."Crédits" := amnt;
        rec.Modify();
        DirectorCue.Get();
        DirectorCue.CalcFields("Montant épargne");
        "Total" := DirectorCue."Montant épargne";
    end;

    var
        //TotalDépots: Decimal;
        Crédits: Integer;
        "Total": Decimal;
}