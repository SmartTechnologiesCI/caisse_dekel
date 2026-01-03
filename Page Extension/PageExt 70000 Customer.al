pageextension 70040 "Customer" extends "Customer Card"
{

    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        modify(Name)
        {
            ShowMandatory = true;
        }
        modify(Address)
        {
            ShowMandatory = true;
        }
        modify("Phone No.")
        {
            ShowMandatory = true;
        }
        modify(MobilePhoneNo)
        {
            ShowMandatory = true;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }

        addlast(General)
        {
            field("Dépôts"; rec."Dépôts")
            {
                CaptionML = ENU = 'Customer saves', FRA = 'Dépot Client';
                ApplicationArea = All;
                Visible = visible;
            }
        }
        addafter("Credit Limit (LCY)")
        {
            field("Limit credit time"; rec."Limit credit time")
            {
                Caption = 'Temps maximal de paiement des crédit';
                ApplicationArea = All;
                Visible = visible;
            }
            field("Last credit date"; rec."Last credit date")
            {
                Caption = 'Date du dernier crédit';
                ApplicationArea = All;
                Visible = visible;
            }
        }
        modify("Credit Limit (LCY)")
        {
            Editable = visible;
        }

        addafter(Name)
        {
            field("Crédits"; rec."Crédits")
            {
                Caption = 'Solde DS';
                ApplicationArea = All;
                Visible = visible;
                trigger OnDrillDown()
                var
                    saleinvoice: record "Sales Invoice Header";
                begin
                    saleinvoice.SetRange("Sell-to Customer No.", rec."No.");
                    saleinvoice.SetRange(CreditP, true);
                    saleinvoice.SetFilter("Remaining Amount", '>0');
                    if saleinvoice.FindFirst() then
                        Page.run(143, saleinvoice);
                end;
            }
            field("Crédits_"; rec."Crédits")
            {
                Caption = 'Solde Dû DS';
                ApplicationArea = All;
                Visible = visible;
                trigger OnDrillDown()
                var
                    saleinvoice: record "Sales Invoice Header";
                begin
                    saleinvoice.SetRange("Sell-to Customer No.", rec."No.");
                    saleinvoice.SetRange(CreditP, true);
                    saleinvoice.SetFilter("Remaining Amount", '>0');
                    if saleinvoice.FindFirst() then
                        Page.run(143, saleinvoice);
                end;
            }

        }
        addafter("Dépôts")
        {
            field(haveBonus; rec."do epargne")
            {
                Caption = 'Activer épargne';
                ToolTip = 'Permet d''activer l''épargne sur un client';
                Visible = false;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    CurrPage.Update();

                end;
            }
            field("Montant prime bonus"; rec."Montant prime bonus")
            {
                Caption = 'Compte épargne';
                // Visible = Rec.isBonus;
                Editable = false;
                trigger OnDrillDown()
                var
                    depot: record "Depôt";
                begin
                    depot.Reset();
                    depot.SetRange(isBonus, true);
                    depot.SetRange("N° client", rec."No.");
                    if depot.FindFirst() then
                        Page.run(Page::"Dépôts Liste", depot);
                end;

            }
        }
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage()
    var
        userPerso: Record "User Personalization";
        SaleInvHeader: Record "Sales Invoice Header";
        SaleInvHeader2: Record "Sales Invoice Header";
        //cutomer: record customer;
        amnt: Decimal;
    begin
        userPerso.SetRange("User ID", UserId);
        if userPerso.FindFirst() then begin
            visible := userPerso."Profile ID" <> 'COMMERCIAL';
        end;

        SaleInvHeader2.Reset();
        SaleInvHeader2.SetRange("Sell-to Customer No.", rec."No.");
        SaleInvHeader2.setRange(CreditP, true);
        SaleInvHeader2.SetRange(Closed, false);
        amnt := 0;
        if SaleInvHeader2.FindFirst() then begin
            repeat
                SaleInvHeader2.CalcFields("Remaining Amount");
                amnt += SaleInvHeader2."Remaining Amount";
            until SaleInvHeader2.Next = 0;
            rec."Crédits" := amnt;
            rec.Modify();
            CurrPage.Update();
        end;

    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin
        if (Rec."No." <> '') then begin
            if Rec.name = '' then
                Error('Veuillez saisir le Nom du client');
            if Rec.Address = '' then
                Error('Veuillez saisir l''adresse du client');
            /*if Rec."Phone No." = '' then
                Error('Veuillez saisir le téléphone du client');*/
            if Rec."Mobile Phone No." = '' then
                Error('Veuillez saisir le téléphone mobile du client');

            Clear(rec."Salesperson Code");
        end;
    end;

    var

        visible: Boolean;

}