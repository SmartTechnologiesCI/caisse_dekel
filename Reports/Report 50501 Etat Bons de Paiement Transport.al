report 70055 "Etat Bons Paiement Transport"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Etat des bons de paiement transport';
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/RDLC/Report 50501 Bons Paiement transport.rdlc';


    dataset
    {
        dataitem(ItemWeighBridge; "Item Weigh Bridge")

        {
            // RequestFilterFields = TICKET, "Code Transporteur";


            column(Text001; Text001) { }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(Text004; Text004) { }
            column(Tex003; Tex003) { }
            column(dateD; dateD) { }
            column(DateF; DateF) { }
            column(NumDocExten; NumDocExten) { }
            column(Type_Operation_Options; Type_Operation_Options) { }
            column(Operation; Operation) { }
            column(TICKET; TICKET) { }
            column(Date_Paiement; Date_Paiement) { }
            column(Driver_Name; "Driver Name") { }
            column(TicketPlanteur; "Ticket Planteur") { }
            column(Text002; Text002) { }
            column(POIDS_ENTREE; "POIDS ENTREE") { }
            column(Item_Origin; "Item Origin") { }
            column(POIDS_NET; "POIDS NET") { }
            column(POIDS_SORTIE; "POIDS SORTIE") { }
            column(Code_Transporteur; "Code Transporteur") { }
            column(Nom_Transporteur; "Nom Transporteur") { }
            column(Nom_planteur; "Nom planteur") { }
            column(Weighing_1_Hour; Format("Weighing 1 Hour", 0, '<Hours24,2>:<Minutes,2>')) { }
            column(Weighing_2_Hour; Format("Weighing 2 Hour", 0, '<Hours24,2>:<Minutes,2>')) { }
            column(Type_opération; "Type opération") { }
            column(Code_planteur; "Code planteur") { }
            column(N_Commande_PIC; "N° Commande PIC") { }
            column(Vehicle_Registration_No; "Vehicle Registration No.") { }
            column(Type_of_Transportation; "Type of Transportation") { }
            column(Beneficiaire; Beneficiaire) { }
            column(Désignation_article; "Désignation article") { }
            column(Weighing_1_Date; Format("Weighing 1 Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(Weighing_2_Date; Format("Weighing 2 Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {

            }
            column(Utilisateur; Utilisateur)
            {

            }
            column(Type_Vehicule; "Type Vehicule")
            {

            }
            column(DescriptionVehicule; DescriptionVehicule)
            {

            }

            column(Matricule_Autre; Matricule_Autre)
            {

            }
            column(NumVehicule; NumVehicule)
            {

            }
            column(Prix; Prix)
            {

            }
            column(NumeroDocTransport; NumeroDocTransport) { }


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if (format(dateD) = '') or (Format(DateF) = '') then begin
                    Error('Veuillez renseigner les dates pour pouvoir effectué les filtes');
                end;
                if dateD > DateF then begin

                end;
                /*  /"Lignes Plan de Chargement".Reset();*/
                ItemWeighBridge.SetFilter(Date_Paiement, '>= %1 & <=%2', dateD, DateF);
                ItemWeighBridge.SetRange(valide, true);
                ItemWeighBridge.SetRange("Statut paiement", true);
            end;

            trigger OnAfterGetRecord()

            var
                myInt: Integer;
                TypeVehicule: Record "Type Vehicule";
                itemBridge: Record "Item Weigh Bridge";
            begin
                if Type_Operation_Options = Type_Operation_Options::"ACHAT DIRECT" then
                    Operation := 'DIRECT';

                if Type_Operation_Options = Type_Operation_Options::"ACHAT COMPTANT" then
                    Operation := 'COMPTANT';

                //Récupération du Montant(CFA) à payer au transporteur
                PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
                PrixAchat.SetFilter("Item No.", '=%1', 'TRANSPORT');
                PrixAchat.SetFilter("Starting Date", '<=%1', "Weighing 1 Date");
                PrixAchat.SetFilter("Ending Date", '>=%1', "Weighing 1 Date");
                PrixAchat.SetRange(Type_Operation_Options, "Type opération");
                if PrixAchat.FindFirst() then begin
                    Prix := PrixAchat."Direct Unit Cost";
                end;
                //Récupération du poids total et montant total
                // itemBridge.Reset();
                // itemBridge.SetRange(valide, true);
                // itemBridge.setrange("Code Transporteur", ItemWeighBridge."Code Transporteur");
                // itemBridge.SetFilter(Date_Paiement, '>= %1 & <=%2', dateD, DateF);
                // if itemBridge.FindSet() then begin
                //     repeat
                //         totalPoids := totalPoids + itemBridge."POIDS NET";
                //     //  totalMontant := totalMontant + (POIDS_NET * Prix);
                //     until itemBridge.Next() = 0;
                // end;
            end;
        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filtre)
                {

                    Caption = 'Filtre date';

                    field(dateD; dateD)
                    {
                        CaptionML = FRA = 'Date début', ENU = 'Start Date';
                        ApplicationArea = All;

                    }
                    field(DateF; DateF)
                    {
                        CaptionML = FRA = 'Date fin', ENU = 'End Date';
                        ApplicationArea = all;
                    }
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
    }



    var
        dateD: Date;
        DateF: Date;
        NumVehicule: Code[50];
        Utilisateur: Code[250];
        Heure: Text[10];
        myInt: Integer;
        Text001: TextConst ENU = 'DEKEL OIL - AYENOUAN', FRA = 'DEKEL OIL - AYENOUAN';
        Text002: Label 'ABJ-PLATEAU 2EME ETAGE, IMM. ARC-EN-CIEL - TEL : 07 59 07 22 40';
        Tex003: Label 'ANGLE AV. CHARDY ET BOUL.LAGUNAIRE - TEL : 07 77 72 67 64';
        Text004: Label '28 BP 234 ABIDJAN 28 - WWW. DEKELOIL.COM';
        TextA: Label '';
        TextB: Label '';
        Operation: Text[250];
        DescriptionVehicule: Text[250];
        PrixAchat: Record "Prix Achat";
        Prix: Decimal;
        totalPoids: Decimal;
        totalMontant: Decimal;
        CompanyInfo: Record "Company Information";
    // Text002:
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;
}