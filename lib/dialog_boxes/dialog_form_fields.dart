import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insulation_app/models/insulation_type/insulation_type.dart';
import 'package:insulation_app/models/pipe_size/pipe_size.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogFormFields {
  static Widget buildPipeSizeDropdown({
    required PipeSize? value,
    required Function(PipeSize?) onChanged,
    String label = "Välj dimensioner",
  }) {
    return DropdownButtonFormField<PipeSize>(
      value: value,
      items: pipeSizes.map((size) {
        return DropdownMenuItem<PipeSize>(
          value: size,
          child: Text(size.label),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label),
    );
  }

  static Widget buildLengthField({
    required TextEditingController controller,
    String label = "Rör längd (m)",
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      decoration: InputDecoration(labelText: label),
    );
  }

  static Widget buildFirstLayerDropdown({
    required InsulationType? value,
    required Function(InsulationType?) onChanged,
    String label = "Första lager",
  }) {
    return DropdownButtonFormField<InsulationType>(
      value: value,
      items: materials.map((mat) {
        return DropdownMenuItem<InsulationType>(
          value: mat,
          child: Text(mat.name),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label),
    );
  }

  static Widget buildSecondLayerDropdown({
    required InsulationType? value,
    required Function(InsulationType?) onChanged,
    String label = "Andra lager (valfritt)",
  }) {
    return DropdownButtonFormField<InsulationType?>(
      value: value,
      items: [
        const DropdownMenuItem<InsulationType?>(
          value: null,
          child: Text("Inget andra lager"),
        ),
        ...materials.map((mat) {
          return DropdownMenuItem<InsulationType?>(
            value: mat,
            child: Text(mat.name),
          );
        }),
      ],
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label),
    );
  }

  static Widget buildTextField({
    required TextEditingController controller,
    required String label,
    bool isRequired = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  static Widget buildAddressField({
    required TextEditingController controller,
    required BuildContext context,
    String label = "Adress",
    required Future<void> Function() onOpenMap,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.map,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: onOpenMap,
        ),
      ),
    );
  }

  static Widget buildPhoneField({
    required TextEditingController controller,
    required BuildContext context,
    String label = "Kontaktnummer",
    required Future<void> Function() onCallPhone,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.phone_android,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: onCallPhone,
        ),
      ),
    );
  }

  static Widget buildDatePicker({
    required BuildContext context,
    required DateTime selectedDate,
    required Function(DateTime) onDateChanged,
  }) {
    return InkWell(
      onTap: () async {
        final ThemeData theme = Theme.of(context);
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2010),
          lastDate: DateTime(2026),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: theme.colorScheme.copyWith(
                  primary: theme.primaryColor,
                  onPrimary: Colors.white,
                  onSurface: Colors.black87,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null && picked != selectedDate) {
          onDateChanged(picked);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedDate.toLocal().toString().split(" ")[0],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.secondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> openGoogleMaps(String address) async {
    String encodedAddress = Uri.encodeComponent(address);
    String url =
        "https://www.google.com/maps/search/?api=1&query=$encodedAddress";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchPhoneCall(String phoneNumber) async {
    final Uri urlParsed = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed);
    } else {
      throw 'Could not launch call to: $phoneNumber';
    }
  }

  static List<Widget> buildDialogButtons({
    required BuildContext context,
    required VoidCallback onSubmit,
    required String submitButtonText,
    String cancelButtonText = "Avbryt",
    VoidCallback? onCancel,
  }) {
    return [
      TextButton(
        onPressed: () {
          if (onCancel != null) {
            onCancel();
          }
          Navigator.pop(context);
        },
        child: Text(cancelButtonText),
      ),
      ElevatedButton(
        onPressed: onSubmit,
        child: Text(submitButtonText),
      ),
    ];
  }

  static Widget spacer() {
    return const SizedBox(height: 10);
  }
}
