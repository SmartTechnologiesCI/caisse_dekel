page 70012 "Liste des transactions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Transactions;
    // SourceTableView = where("validée" = const(false));
    layout
    {
        area(Content)
        {
            repeater("Liste des transactions")
            {
                field("N°"; "N°")
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(Heure; Heure)
                {
                    ApplicationArea = All;
                }
                field(Source; Source)
                {
                    ApplicationArea = All;
                }
                field("N° Document"; "N° Document")
                {
                    ApplicationArea = All;
                }
                field(DocExtern; DocExtern)
                {
                    ApplicationArea = All;
                }
                field(Multipaiement; Multipaiement)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("N° Client"; "N° Client")
                {
                    ApplicationArea = All;
                }
                field(Nom; Nom)
                {
                    ApplicationArea = All;
                }
                field("Mode de reglement"; "Mode de reglement")
                {
                    ApplicationArea = All;
                }
                field(Montant; Montant)
                {
                    ApplicationArea = All;
                }
                field("Montant recu"; "Montant recu")
                {
                    ApplicationArea = All;
                }
                field("Montant rendu"; "Montant rendu")
                {
                    ApplicationArea = All;
                }
                field("Montant NET"; "Montant NET")
                {
                    ApplicationArea = All;
                }
                field("Montant restant"; "Montant restant")
                {
                    ApplicationArea = All;
                }
                field(recouvrement; recouvrement)
                {
                    ApplicationArea = All;
                }
                field("user id"; "user id")
                {
                    ApplicationArea = All;
                }

                field("Code caisse"; "Code caisse")
                {
                    ApplicationArea = All;
                    Visible = true;
                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Transactions validées")
            {
                ApplicationArea = All;
                Caption = 'Liste des transactions archivées';
                Promoted = true;
                PromotedCategory = Process;
                Image = PostedPayment;
                trigger OnAction();
                var
                    Transactiosn: Record Transactions;
                begin
                    Transactiosn.SetFilter("Date", '<%1', WorkDate());
                    Page.run(70034, Transactiosn);
                end;
            }
            action("Actualiser")
            {
                ApplicationArea = All;
                Caption = 'Actualiser';
                Promoted = true;
                PromotedCategory = Process;
                Image = Refresh;
                trigger OnAction();
                var
                    Transactiosn: Record Transactions;
                begin
                    if Transactiosn.FindFirst() then begin
                        repeat
                            Transactiosn."Montant NET" := Transactiosn."Montant recu" - Transactiosn."Montant rendu";
                            Transactiosn.Modify();
                        until Transactiosn.Next = 0;
                    end;
                    CurrPage.Update();
                end;
            }

        }
    }
    var
        editable: Boolean;
        userProfiles: Code[50];

    trigger OnOpenPage()
    var
        userPerso: record "User Personalization";
    begin
        // SetRange(Date, WorkDate);
        // userPerso.SetRange("User ID", UserId);
        // if userPerso.FindFirst() then begin
        //     editable := userPerso."Profile ID" <> 'COMMERCIAL';
        //     CurrPage.Editable := editable;
        // end;
    end;

    trigger OnAfterGetRecord()
    var
        client: record customer;
    begin
        client.SetRange("No.", "N° Client");
        if client.FindFirst() then
            Nom := client.Name;
    end;
}