page 70057 "Liste transactions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Transactions;
    //Editable = false;
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
                field(recouvrement; recouvrement)
                {
                    ApplicationArea = All;
                }
                field("user id"; "user id")
                {
                    ApplicationArea = All;
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

        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //SetRange(Date, WorkDate);

        SetCurrentKey(Date);
        SetAscending(Date, false);
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