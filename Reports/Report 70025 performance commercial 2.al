report 70025 "New Perf Comm"
{
    RDLCLayout = 'Reports\RDLC\Report 70025 npc.rdlc';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    DataAccessIntent = ReadOnly;
    ApplicationArea = Basic, Suite;
    dataset
    {

        dataitem("Ligne Ojectif Commercial"; "Ligne Ojectif Commercial")
        {
            // RequestFilterFields = "Date debut";
            column(TypeLigne; TypeLigne) { }
            column(No_Article; "No Article") { }
            column(No_Task; "No Task") { }
            column(Qte_Poids; "Qte Poids") { }
            column(Description; Description) { }
            column(Date_debut; "Date debut") { }
            column(qteVendue; qteVendue) { }
            column(performance; performance) { }
            column(bonus; bonus) { }
            column(Prime; Prime) { }
            column(primeBonus; primeBonus) { }


            dataitem("Objectif Commercial"; "Objectif Commercial")
            {
                column(No; No) { }
                column(Groupe; Groupe) { }


                column(tailleGroupe; tailleGroupe) { }
                dataitem("Team Salesperson"; "Team Salesperson")
                {
                    DataItemLink = "Team Code" = field(groupe);
                    column(Salesperson_Code; "Salesperson Code") { }


                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetRange("Type de groupe", "Type de groupe"::Commercial);
                end;
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                salesInvLine: Record "Sales Invoice Line";
                salesInvHeader: Record "Sales Invoice Header";
                sil: Record "Sales Invoice Line";
                sih: Record "Sales Invoice Header";
            begin

/*                 montantPrime := Prime / taille_Groupe;

                salesInvHeader.Reset();
                qteVendue := 0;
                salesInvHeader.SetRange("Posting Date", date_Debut, date_Fin);
                salesInvHeader.SetRange("Salesperson Code", "Team Salesperson".Utilisateur);
                if salesInvHeader.FindFirst() then begin
                    salesInvHeader.CalcFields(Cancelled);
                    salesInvHeader.SetRange(Cancelled, false);
                    if salesInvHeader.FindFirst() then begin
                        repeat
                            salesInvLine.Reset();
                            salesInvLine.SetRange("Document No.", salesInvHeader."No.");

                            if TypeLigne = TypeLigne::Article then begin
                                salesInvLine.SetRange("No.", "Ligne Ojectif Commercial"."No Article");
                            end else
                                salesInvLine.SetRange("Item Category Code", "Ligne Ojectif Commercial"."No Article");
                            if salesInvLine.FindFirst() then begin
                                repeat
                                    qteVendue := qteVendue + salesInvLine.Quantity;
                                until salesInvLine.Next() = 0;
                            end;
                        until salesInvHeader.Next() = 0;
                    end;
                end;
                performance := qteVendue / ("Qte Poids" / taille_Groupe);
                if qteVendue >= "Qte Poids" then begin
                    bonus := (qteVendue * montantPrime) / "Qte Poids";
                    primeBonus := (montantPrime) * (performance);
                end else begin
                    bonus := 0;
                    primeBonus := 0;
                end; */


            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange("Date debut", date_Debut, date_Fin);

            end;
        }

        /*         dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {

                    RequestFilterFields = "Posting Date";
                    //DataItemLink = "No." = field("No Article");
                    column(No_item; "No.") { }
                    column(item_type; Type) { }
                    column(Item_Category_Code; "Item Category Code") { }


                    trigger OnAfterGetRecord()
                    var
                        salesInvHeader: Record "Sales Invoice Header";
                    begin
                        salesInvHeader.Reset();
                        salesInvHeader.SetRange("No.", "Sales Invoice Line"."Document No.");
                        if salesInvHeader.FindFirst() then begin
                            salesInvHeader.CalcFields(Cancelled);
                            salesInvHeader.SetRange(Cancelled, true);
                            if salesInvHeader.FindFirst() then
                                CurrReport.Skip();
                        end;


                    end;
                } */




    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Periode)
                {
                    field(date_Debut; date_Debut) { }
                    field(date_Fin; date_Fin) { }

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }

        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            date_Debut := DMY2Date(01, DATE2DMY(WorkDate, 2), DATE2DMY(WorkDate, 3));
            date_Fin := WorkDate();
            EmailReceveur := 'ikacou@smartechnologies.com';

        end;
    }




    var
        Perdiode: Date;
        commercial: Text[50];
        date_Debut: Date;
        date_Fin: Date;
        objectifCom: Record "Objectif Commercial";
        performance: Decimal;
        performanceParPersonne: Decimal;
        bonus: Decimal;
        montantPrime: Decimal;

        ekip: Record Team;
        // utilisateur: Code[50];
        qteVendue: Decimal;

        // teamSalesPerson: Record "Team Salesperson";
        userSetup: Record "User Setup";

        salesIvoiceHeader: Record "Sales Invoice Header";
        articleVendu: Record item;
        taille_Groupe: Decimal;
        EmailReceveur: Text;
        primeBonus: Decimal;
        dateDebutLoc: Date;
        dateFinLoc: Date;
        datefilter: DateTime;
}