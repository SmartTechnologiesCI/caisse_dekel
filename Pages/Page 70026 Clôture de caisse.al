page 70026 "Clôture de caisse card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Ouverture de caisse";

    layout
    {
        area(Content)
        {
            group(Général)
            {
                field(No; rec.No)
                {
                    ApplicationArea = All;
                    Caption = 'N°';
                }
                field(Date; rec."Date clôture")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
                field(Heure; rec."Heure clôtutre")
                {
                    ApplicationArea = All;
                    Caption = 'Heure';
                }
                field("Code caisse"; rec."Code caisse")
                {
                    ApplicationArea = All;
                    Caption = 'Code caisse';
                }
                field("User id"; rec."User id")
                {
                    ApplicationArea = All;
                    Caption = 'Utilisateur';
                }

                field("Montant clôture"; rec."Montant clôture")
                {
                    ApplicationArea = All;
                    Caption = 'Montant clôture';
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Clôturer")
            {
                ApplicationArea = All;
                Image = Post;
                promoted = true;
                PromotedCategory = Process;
                Caption = 'Clôtuer la caisse';
                trigger OnAction()
                var
                    Transactiosn: Record Transactions;
                begin
                    if (format(rec."Montant clôture") <> '') then begin
                        if (Confirm('Voulez-vous clôturer la caisse ? Annulation impossible !')) then begin
                            if (Rec."Montant clôture" = 0) then begin
                                if (NOT Confirm('Vous êtes sur le point de valider la clôture avec un montant de 0 FCFA ! Souhaitez-vous valider ?')) then begin
                                    EXIT;
                                end;
                            end;
                            Transactiosn.SetRange(Date, rec."Date ouverture");
                            Transactiosn.SetRange("Code caisse", rec."Code caisse");
                            if (Transactiosn.FindFirst()) then
                                repeat
                                    Transactiosn."validée" := true;
                                    Transactiosn.Modify();
                                until Transactiosn.Next = 0;

                            rec.status := rec.status::Closed;
                            CurrPage.Update();

                        end;
                    end;
                end;
            }
            action("Transactions du jour")
            {
                ApplicationArea = All;
                Image = CashFlow;
                promoted = true;
                PromotedCategory = Process;
                Caption = 'Liste des trasactions du jour';
                trigger OnAction()
                var
                    Transactiosn: Record Transactions;
                begin
                    Transactiosn.SetRange(Date, rec."Date ouverture");
                    Transactiosn.SetRange("Code caisse", rec."Code caisse");
                    if (Transactiosn.FindFirst()) then
                        Page.run(70002, Transactiosn);
                end;
            }
            action("Transactions validées du jour")
            {
                ApplicationArea = All;
                Image = CashFlow;
                promoted = true;
                PromotedCategory = Process;
                Caption = 'Liste des trasactions validées du jour';
                trigger OnAction()
                var
                    Transactiosn: Record Transactions;
                begin
                    Transactiosn.SetRange(Date, rec."Date ouverture");
                    Transactiosn.SetRange("Code caisse", rec."Code caisse");
                    if (Transactiosn.FindFirst()) then
                        Page.run(70034, Transactiosn);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
    begin
        rec."Date clôture" := WorkDate();
        rec."Heure clôtutre" := time;
        Modify();
    end;

    var
        myInt: Integer;
}