page 70033 "Liste des encais. du jour"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Encaissement;
    //Editable = false;
    Caption = 'Liste des encaissements du jour';
    //SourceTableView = where("Validé" = const(false));
    layout
    {
        area(Content)
        {
            repeater("Liste encaissement")
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
                field("N° commande"; "N° commande")
                {
                    ApplicationArea = All;
                }
                field("N° client"; "N° client")
                {
                    ApplicationArea = All;
                }
                field("Nom client"; "Nom client")
                {
                    ApplicationArea = All;
                }
                field("Mode de paiement"; "Mode de paiement")
                {
                    ApplicationArea = All;
                }
                field("NET a payer"; "NET a payer")
                {

                }
                field("Montant NET"; "Montant NET")
                {
                    ApplicationArea = All;
                }
                field(Montant; Montant)
                {
                    ApplicationArea = All;
                }
                field(Monnaie; Monnaie)
                {
                    ApplicationArea = All;
                }

                field("Code caisse"; "Code caisse")
                {
                    ApplicationArea = All;
                }
                /* field("Validé"; "Validé")
                 {
                     ApplicationArea = All;
                 }*/
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Liste des encaissements validés")
            {
                ApplicationArea = All;
                Image = PostedTimeSheet;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction();
                var
                    encaissement: Record Encaissement;
                begin
                    encaissement.SetRange("Validé", true);
                    encaissement.FindFirst();
                    Page.Run(Page::"Liste des encais. valides", encaissement);
                end;
            }

            action("Imprimer")
            {
                ApplicationArea = All;
                Image = PrintDocument;
                Caption = 'Imprimer Tickets';
                Promoted = true;
                PromotedCategory = Process;
                Visible = prof = 'DIRECTEUR';
                trigger OnAction()
                var
                    Encaissement2: Record Encaissement;
                begin
                    Encaissement2.Reset();
                    Encaissement2.SetRange("N°", "N°");
                    if (Encaissement2.FindLast()) then
                        Report.Run(70000, true, false, Encaissement2);
                end;
            }
        }
    }
    var
        userProf: record "User Personalization";
        prof: Text[100];

    trigger OnOpenPage()
    var
        myInt: Integer;
        page: Page 151;
    begin

        //SetRange(Date, WorkDate);
        userProf.SetRange("User ID", UserId);
        if userProf.FindFirst() then
            prof := userProf."Profile ID";

        SetRange(Date, WorkDate);

        SetCurrentKey(Date);
        SetAscending(Date, false);
    end;


    trigger OnAfterGetRecord()
    var
        client: record customer;
    begin
        client.SetRange("No.", "N° Client");
        if client.FindFirst() then
            "Nom client" := client.Name;
    end;
}